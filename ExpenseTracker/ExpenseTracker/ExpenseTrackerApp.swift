//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Gio Angelo Lat on 8/24/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transationListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transationListVM)
        }
    }
}
