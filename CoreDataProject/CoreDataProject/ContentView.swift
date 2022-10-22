//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Cheng Liang(Louis) on 2022/10/20.
//

import SwiftUI
import CoreData

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    
    let students = [Student(name: "Dick"), Student(name: "Ass")]
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>
//
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH %@", "E")) var ships: FetchedResults<Ship>
    var body: some View {
//        VStack {
//            List(wizards, id: \.self) { wizard in
//                Text(wizard.name ?? "Unknown")
//
//            }
//
//            Button("Add") {
//                let wizard = Wizard(context: moc)
//                wizard.name = "Harry"
//            }
//
//            Button("Save") {
//                do {
//                    try moc.save()
//                }catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        VStack {
            List(ships, id: \.self) { ship in
                
                Text(ship.name ?? "Unknown name")
                
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship1.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
