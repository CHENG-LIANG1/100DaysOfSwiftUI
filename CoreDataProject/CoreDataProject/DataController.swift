//
//  DataController.swift
//  CoreDataProject
//
//  Created by Cheng Liang(Louis) on 2022/10/20.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init(){
        container.loadPersistentStores { des, err in
            if let err = err {
                print("Failed")
            }
        }
    }
     
}
