//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Cheng Liang(Louis) on 2022/10/7.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
