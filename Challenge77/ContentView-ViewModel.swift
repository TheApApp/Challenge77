//
//  ContentView-ViewModel.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/30/22.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var photos: [Photo]

        @Published var showingPhotoPicker = false
        @Published var inputImage: UIImage?

        @Published var showingSaveError = false

        @Published var showingNamePrompt = false
        @Published var name = "Unknown Name"

        @Published var locationFetcher = LocationFetcher()
        @Published var locationTracking = false


        let photo = Photo.example

        let savePath = FileManager.documentDirectory.appendingPathComponent("Faces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                photos = try JSONDecoder().decode([Photo].self, from: data)
            } catch {
                photos = []
            }
        }

        func save() {
            showingNamePrompt = true
            do {
                let data = try JSONEncoder().encode(photos)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }

        func saveImage() {
            guard let inputImage = inputImage else { return }
            let uuid = UUID()

            let imageSaver = ImageSaver()

            imageSaver.successHandler = {
                print("Success")
            }

            imageSaver.errorHandler = {
                print("Ooops \($0.localizedDescription)")
            }

            if locationTracking {
                print("tracking location")
                if let location = self.locationFetcher.lastKnownLocation {
                    photos.append(Photo(id: uuid, name: name, location: Location(latitude: location.latitude, longitude: location.longitude)))
                    print("Location is \(location.longitude) by \(location.latitude)")
                } else {
                    photos.append(Photo(id: uuid, name: name))
                }
            } else {
                print("No location traxking")
                photos.append(Photo(id: uuid, name: name))
            }
            save()

            imageSaver.writeToDocumentsDirectory(image: inputImage, named: String("\(uuid)"))
        }
    }
}
