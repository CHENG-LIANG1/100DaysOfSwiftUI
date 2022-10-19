//
//  DataController.swift
//  Bookworm
//
//  Created by Cheng Liang(Louis) on 2022/10/15.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores { des, err in
            if let err = err {
                print("Failed")
            }
        }
    }
     
}
