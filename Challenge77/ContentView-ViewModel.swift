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

            photos.append(Photo(id: uuid, name: name))
            save()

            imageSaver.writeToDocumentsDirectory(image: inputImage, named: String("\(uuid)"))
        }
    }
}
