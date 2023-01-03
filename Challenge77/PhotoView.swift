//
//  PhotoView.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import MapKit
import SwiftUI

struct MapLocation {
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct PhotoView: View {
    let photo: Photo
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var body: some View {
        VStack {
            // Need to figure out how to reference the file name at the URL

            displayImage(imageNamed: "\(photo.id)")
                .resizable()
                .scaledToFit()
            Text("\(photo.name)")
            Spacer()
            Map(coordinateRegion: $mapRegion)
            Spacer()
        }
        .padding()
    }

    init(photo: Photo) {
        _mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: photo.location?.latitude ?? 51.5, longitude: photo.location?.longitude ?? -0.12), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        self.photo = photo
    }

    func displayImage(imageNamed: String) -> Image {
        let path = "\(FileManager.documentDirectory.appending(path: imageNamed))"
        // remove the file:// from the path before access contents of (this is UGLY)
        guard let displayImage = UIImage(contentsOfFile: String(path.dropFirst(7))) else { return Image(systemName: "nosign")}
        return Image(uiImage: displayImage)
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo.example)
    }
}
