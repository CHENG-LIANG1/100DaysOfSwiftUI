//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Cheng Liang(Louis) on 2022/10/20.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
