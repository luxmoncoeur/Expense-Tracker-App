//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Gio Angelo Lat on 8/24/25.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

//Turns an object into a publisher that notify its subscribers of its state changes
final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransaction()
    }
    
    func getTransaction(){
        guard let url = URL(string: "https://gist.githubusercontent.com/luxmoncoeur/33c8ebf14d7c14d24ed8d710fdfce5bc/raw/68679c1a70a3d2c1341df84e9cad35cb87c06e3a/transactions") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error catching transactions", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month }
        return groupedTransactions
            
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("Accumulate Transactions")
        guard !transactions.isEmpty else { return [] }
        
        // Full interval from earliest to latest transaction
        let dateInterval = DateInterval(
            start: transactions.map { $0.dateParse }.min()!,
            end: transactions.map { $0.dateParse }.max()!
        )
        print("Date Interval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: dateInterval.end, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter {
                Calendar.current.isDate($0.dateParse, inSameDayAs: date) && $0.isExpense
            }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedOff()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "Daily Total", dailyTotal, "Daily Sum", sum)
        }
        
        return cumulativeSum
    }

}
