//
//  FileManager-DocumentsDirectory.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//


import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
