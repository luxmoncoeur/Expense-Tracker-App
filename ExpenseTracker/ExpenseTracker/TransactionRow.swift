//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Gio Angelo Lat on 8/24/25.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack (spacing: 20){
            //MARK: Transaction Category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appIcon.opacity(0.30))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.appIcon)
                }
            
            VStack(alignment: .leading, spacing: 6){
                //MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: Transaction Caetgory
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //MARK: Transaction Date
                Text(transaction.dateParse, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    
            }
            
            Spacer()
            
            //Transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "PHP"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
}

#Preview {
    TransactionRow(transaction: transactionPreviewData)
        .preferredColorScheme(.dark)
}



