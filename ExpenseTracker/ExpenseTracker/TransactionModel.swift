//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by Gio Angelo Lat on 8/24/25.
//

import Foundation
import SwiftUIFontIcon

/*
 declared with let is constant, while var is editable
 */
struct Transaction: Identifiable, Decodable, Hashable{
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    var isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var icon: FontAwesomeCode {
        if let category = Category.all.first(where: { $0.id == categoryId}){
            return category.icon
        }
        return .question
    }
    
    var dateParse: Date {
        date.dateParse()
    }
    var signedAmount: Double {
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String {
        dateParse.formatted(.dateTime.year().month(.wide))
    }
}

//enums define a special group of related values
enum TransactionType: String{
    case debit = "Debit"
    case credit = "Credit"
}

struct Category {
    let id: Int
    let name: String
    let icon: FontAwesomeCode
    var mainCategoryId: Int?
}

extension Category {
    // Main category IDs
        // 1 = Food & Drink, 2 = Shopping, 3 = Transport, 4 = Entertainment, 5 = Electronics
        
    // MARK: - Main Categories
        static let foodAndDrink = Category(id: 1, name: "Food & Drink", icon: .carrot)
        static let shopping = Category(id: 2, name: "Shopping", icon: .shopping_bag)
        static let transport = Category(id: 3, name: "Transport", icon: .bus)
        static let entertainment = Category(id: 4, name: "Entertainment", icon: .film)
        static let electronics = Category(id: 5, name: "Electronics", icon: .laptop)

        // MARK: - Subcategories
        static let coffee = Category(id: 100, name: "Coffee", icon: .coffee, mainCategoryId: 1)
        static let groceries = Category(id: 105, name: "Groceries", icon: .shopping_cart, mainCategoryId: 1)
        static let beverages = Category(id: 107, name: "Beverages", icon: .water, mainCategoryId: 1)
        static let food = Category(id: 112, name: "Food", icon: .carrot, mainCategoryId: 1)
        static let cafe = Category(id: 114, name: "Cafe", icon: .mug_hot, mainCategoryId: 1)
        
        static let shoppingCat = Category(id: 101, name: "Shopping", icon: .shopping_bag, mainCategoryId: 2)
        static let clothing = Category(id: 108, name: "Clothing", icon: .heart, mainCategoryId: 2)
        static let books = Category(id: 111, name: "Books", icon: .book, mainCategoryId: 2)
        static let apparel = Category(id: 116, name: "Apparel", icon: .heart, mainCategoryId: 2)
        static let supermarket = Category(id: 118, name: "Supermarket", icon: .water, mainCategoryId: 2)
        static let onlineShopping = Category(id: 119, name: "Online Shopping", icon: .shopping_cart, mainCategoryId: 2)
        
        static let transportCat = Category(id: 102, name: "Transport", icon: .bus, mainCategoryId: 3)
        static let taxi = Category(id: 109, name: "Taxi", icon: .taxi, mainCategoryId: 3)
        static let ride = Category(id: 117, name: "Ride", icon: .taxi, mainCategoryId: 3)
        
        static let entertainmentCat = Category(id: 103, name: "Entertainment", icon: .film, mainCategoryId: 4)
        static let music = Category(id: 106, name: "Music", icon: .headphones, mainCategoryId: 4)
        static let movies = Category(id: 110, name: "Movies", icon: .camera, mainCategoryId: 4)
        static let streaming = Category(id: 115, name: "Streaming", icon: .film, mainCategoryId: 4)
        
        static let electronicsCat = Category(id: 104, name: "Electronics", icon: .laptop, mainCategoryId: 5)
        static let gadgets = Category(id: 113, name: "Gadgets", icon: .mobile, mainCategoryId: 5)
}

extension Category {
    static let categories: [Category] = [
        .foodAndDrink, .shopping, .transport, .entertainment, .electronics
    ]
    
    static let subcategories: [Category] = [
        .coffee, .groceries, .beverages, .food, .cafe,
        .shoppingCat, .clothing, .books, .apparel, .supermarket, .onlineShopping,
        .transportCat, .taxi, .ride,
        .entertainmentCat, .music, .movies, .streaming,
        .electronicsCat, .gadgets
    ]
    
    static let all: [Category] = categories + subcategories
}

