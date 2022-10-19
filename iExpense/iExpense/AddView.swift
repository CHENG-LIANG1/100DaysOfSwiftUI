//
//  AddView.swift
//  iExpense
//
//  Created by Cheng Liang(Louis) on 2022/8/28.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
        
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    

    var body: some View {
        
        NavigationView{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(expenses.types, id: \.self){
                        Text($0)
                    }
                }

                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "CNY"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }

        }

    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
