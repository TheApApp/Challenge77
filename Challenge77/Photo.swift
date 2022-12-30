//
//  Photo.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import Foundation

struct Photo: Codable, Comparable {

    var id: UUID
    var name: String

    static let example = Photo(id: UUID(uuidString: "48E81F0E-59D3-4118-B026-31251B7463B8")!, name: "Example Photo")

    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
}
