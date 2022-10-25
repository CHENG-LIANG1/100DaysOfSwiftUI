//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Cheng Liang(Louis) on 2022/10/22.
//

import SwiftUI
import CoreData

enum Predicate: String {
    case beginsWith = "BEGINSWITH"

}


struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) {item in
            self.content(item)
        }
    }
    
    
    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [SortDescriptor<T>],@ViewBuilder content: @escaping (T) -> Content ) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate) %@", filterKey, filterValue))
        
        self.content = content
    }
}
//
//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
