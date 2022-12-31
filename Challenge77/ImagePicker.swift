//
//  ImagePicker.swift
//  InstaFilter
//
//  Created by Michael Rowe on 12/29/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)  // let's get rid of the picker
            
            guard let provider = results.first?.itemProvider else { return } // let's see if there is anything in the provider if not bail out

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self ) { image, _ in
                        self.parent.image = image as? UIImage // need to type cast
                }
            }
        }
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator  // assign our coordinator as the delegate for our picker
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // we aren't doing anything so no code
    }

    func makeCoordinator() -> Coordinator {
        // this talks between UIKit and SwiftUI
        Coordinator(self)
    }

}
