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
    
    @Environment(\.managedObjectContext) var moc
    
//    let students = [Student(name: "Dick"), Student(name: "Ass")]

    
    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>

//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])) var ships: FetchedResults<Ship>
    
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "name BEGINSWITH[c] %@", "e")) var ships: FetchedResults<Ship>
    
    @State private var lastNameFilter = "A"
    
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
//    @FetchRequest(sortDescriptors: []) var candies: FetchRequest<Candy>
    
    var body: some View {
        
        
//MARK: Constraints
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
//
        
//MARK:  NSPredicat
//        VStack {
//            List(ships, id: \.self) { ship in
//
//                Text(ship.name ?? "Unknown name")
//
//            }
//
//            Button("Add Examples") {
//                let ship1 = Ship(context: moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: moc)
//                ship2.name = "Defiant"
//                ship1.universe = "Star Trek"
//
//                let ship3 = Ship(context: moc)
//                ship3.name = "Falcon"
//                ship3.universe = "Star Wars"
//
//                let ship4 = Ship(context: moc)
//                ship4.name = "Executor"
//                ship4.universe = "Star Wars"
//
//                try? moc.save()
//            }
//        }
        
//MARK: Dynamic Filtering
        
//        VStack {
//            FilteredList(filterKey: "lastname", filterValue: lastNameFilter) { (singer: Singer) in
//
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
//
//
//            Button("Added Singers") {
//                let taylor = Singer(context: moc)
//                taylor.firstname = "Taylor"
//                taylor.lastname = "Swift"
//                let ed = Singer(context: moc)
//                ed.firstname = "Ed"
//                ed.lastname = "Sheeran"
//
//                let adele = Singer(context: moc)
//                adele.firstname = "Adele"
//                adele.lastname = "Adkins"
//
//                try? moc.save()
//            }
//        }
//
//        Button("Show A"){
//            lastNameFilter = "A"
//        }
//
//        Button("Show S"){
//            lastNameFilter = "S"
//        }
//
        
//MARK: One-to-many
        
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                            Text(country.shortname ?? "nil")
                        }
                    }

                }
            }


            Button("Add Examples Candy-Country") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortname = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: moc)
                candy2.name = "Moon"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortname = "US"
                candy2.origin?.fullName = "United States"

                let candy3 = Candy(context: moc)
                candy3.name = "Saturn"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortname = "JP"
                candy3.origin?.fullName = "Japan"


            }
            
            Button("Save") {
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
