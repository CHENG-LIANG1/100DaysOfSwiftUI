//
//  ContentView.swift
//  HotProspects
//
//  Created by Cheng Liang(Louis) on 2022/11/6.
//

import SwiftUI


@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}




struct ContentView: View {
    @StateObject private var user = User()
    
    @State private var selectedTab = "Two"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .tabItem{
                    Label("One", systemImage: "star")
                }
                .tag("One")
            Text("Tab 2")
                .onTapGesture {
                    selectedTab = "One"
                }
                .tabItem{
                    Label("Two", systemImage: "circle")
                }
                .tag("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
