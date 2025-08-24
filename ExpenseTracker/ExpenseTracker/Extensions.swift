//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Gio Angelo Lat on 8/24/25.
//

import Foundation
import SwiftUI

extension Color {
    static let appBackground = Color("Background")
    static let appIcon = Color("Icon")
    static let appText = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumeric: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }() //directly calling the method
}
extension String{
    func dateParse() -> Date{
        guard let parsedDate = DateFormatter.allNumeric.date(from: self) else { return Date()}
        return parsedDate
    }
}

extension Date {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedOff() -> Double {
        return (self * 100).rounded() / 100
    }
}
