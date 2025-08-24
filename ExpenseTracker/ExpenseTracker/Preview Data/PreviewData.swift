//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Gio Angelo Lat on 8/24/25.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "08/03/2025", institution: "Maya", account: "Visa", merchant: "Apple", amount: 407.58 , type: "Debit", categoryId: 777, category: "Gadgets", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 20)
