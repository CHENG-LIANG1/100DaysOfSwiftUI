//
//  FileManager.swift
//  Bucket List
//
//  Created by Cheng Liang(Louis) on 2022/11/5.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
