//
//  ContentView.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.photos.sorted(), id: \.id) {
                NavigationLink("\($0.name)", destination: PhotoView(photo: $0))
            }
            .navigationTitle("Faces")
            .toolbar {
                Button {
                    viewModel.showingPhotoPicker = true
                } label: {
                    Image(systemName: "plus")
                }
                Button {
                    viewModel.locationTracking.toggle()
                    if viewModel.locationTracking {
                        viewModel.locationFetcher.start()
                    } else {
                        viewModel.locationFetcher.stop()
                    }
                } label: {
                    Image(systemName: viewModel.locationTracking ? "location" : "location.slash")
                }
            }
            .sheet(isPresented: $viewModel.showingPhotoPicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.showingNamePrompt = true
            }
            .alert("Ooops!", isPresented: $viewModel.showingSaveError) {
                Button("OK") {}
            } message: {
                Text("Sorry, there was an error saving your image - please check that you have granted permission to save images.")
            }
            .alert("Name", isPresented: $viewModel.showingNamePrompt) {
                TextField("Enter name", text: $viewModel.name)
                Button("OK", action: viewModel.saveImage)
            } message: {
                Text("Please provide a name so you can remember them later.")
            }
        }
    }

    func submit() {
        viewModel.saveImage()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
