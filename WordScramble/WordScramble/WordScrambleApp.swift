//
//  WordScrambleApp.swift
//  WordScramble
//
//  Created by Cheng Liang(Louis) on 2022/8/13.
//

import SwiftUI

@main
struct WordScrambleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
