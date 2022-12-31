//
//  Photo.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import CoreLocation
import Foundation

struct Location: Codable {
    var latitude: Double
    var longitude: Double
}

struct Photo: Codable, Comparable {
    var id: UUID
    var name: String
    var location: Location?

    static let example = Photo(id: UUID(uuidString: "48E81F0E-59D3-4118-B026-31251B7463B8")!, name: "Example Photo", location: Location(latitude: 37.3346, longitude: 122.0090))

    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name == rhs.name
    }
}
