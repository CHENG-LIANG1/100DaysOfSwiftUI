//
//  ContentView.swift
//  iExpense
//
//  Created by Cheng Liang(Louis) on 2022/8/25.
//

import SwiftUI


struct ContentView: View {
    @State private var showingAddExpense = false
    @StateObject var expenses = Expenses()
    @State private var personalExpenses = [ExpenseItem]()
    @State private var businessExpenses = [ExpenseItem]()
    
    func addItemsByType(){
        print("dick")
        personalExpenses = []
        businessExpenses = []
        for item in expenses.items {
            if item.type == "Personal"{
                personalExpenses.append(item)
            }else {
                businessExpenses.append(item)
            }
        }
    }
    
    
    
    var body: some View {
        
        NavigationView {
            List {
                
                SectionView(items: personalExpenses)
                
                SectionView(items: businessExpenses)
                

            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                   showingAddExpense = true
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
            
        }
        .sheet(isPresented: $showingAddExpense, onDismiss: addItemsByType) {
            AddView(expenses: expenses)
        }
        
        .onAppear(perform: addItemsByType)
        

    }
    
    mutating func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
