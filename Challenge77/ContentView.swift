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
            }
            .sheet(isPresented: $viewModel.showingPhotoPicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .onChange(of: viewModel.inputImage) { _ in
                // Need to prompt to name the file
                viewModel.saveImage()
            }
            .alert("Ooops!", isPresented: $viewModel.showingSaveError) {
                Button("OK") {}
            } message: {
                Text("Sorry, there was an error saving your image - please check that you have granted permission to save images.")
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
