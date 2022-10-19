//
//  SectionView.swift
//  iExpense
//
//  Created by Cheng Liang(Louis) on 2022/8/28.
//

import SwiftUI

struct SectionView: View {
    

    var items = [ExpenseItem]()
    

    
    var body: some View {
        Section {
            ForEach(items, id: \.id) { // based on names uniquely
                item in HStack {
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(.title3)
                        Text(item.type)
                            .font(.headline)
                    }
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "CNY"))
                        .font(item.amount <= 10 ? .system(size: 15, weight: .regular) : item.amount <= 100 ? .system(size: 15, weight: .semibold) : .system(size: 15, weight: .bold))
                }
            }

        }
    }
    

}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(items: [ExpenseItem]())
    }
}
