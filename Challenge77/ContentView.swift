//
//  ContentView.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var photos = [Photo]()

    @State private var showingPhotoPicker = false
    @State private var inputImage: UIImage?

    @State private var showingSaveError = false

    let photo = Photo.example

    let savePath = FileManager.documentDirectory.appendingPathComponent("Faces")

    var body: some View {
        NavigationView {
            List(photos.sorted(), id: \.id) {
                NavigationLink("\($0.name)", destination: PhotoView(photo: $0))
            }
            .navigationTitle("Faces")
            .toolbar {
                Button {
                    showingPhotoPicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingPhotoPicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                // Need to prompt to name the file
                saveImage()
            }
            .alert("Ooops!", isPresented: $showingSaveError) {
                Button("OK") {}
            } message: {
                Text("Sorry, there was an error saving your image - please check that you have granted permission to save images.")
            }
        }
    }

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            photos = try JSONDecoder().decode([Photo].self, from: data)
        } catch {
            photos = []
        }
    }

    func save() {
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
        print("UUID = \(uuid)")

        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success")
        }

        imageSaver.errorHandler = {
            print("Ooops \($0.localizedDescription)")
        }
        
        photos.append(Photo(id: uuid, name: "NEED NAME"))
        save()

        imageSaver.writeToDocumentsDirectory(image: inputImage, named: String("\(uuid)"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
