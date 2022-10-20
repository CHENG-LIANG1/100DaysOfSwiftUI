//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Cheng Liang(Louis) on 2022/10/20.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    
    let students = [Student(name: "Dick"), Student(name: "Ass")]
    
    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
