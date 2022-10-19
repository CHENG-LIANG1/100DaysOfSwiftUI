//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Cheng Liang(Louis) on 2022/8/28.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

