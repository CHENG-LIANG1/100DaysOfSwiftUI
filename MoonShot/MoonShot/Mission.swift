//
//  Mission.swift
//  MoonShot
//
//  Created by Cheng Liang(Louis) on 2022/9/5.
//

import Foundation

struct CrewRole: Codable {
    let name: String
    let role: String
    
}


struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName : String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedlaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
        
    }
    
    
}


