//
//  ImageSaver.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (()->Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    func writeToDocumentsDirectory(image: UIImage, named: String) {
        let url = FileManager.documentDirectory.appending(path: named)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: url, options: [.atomic, .completeFileProtection])
            } catch {
                print("Error saving file to \(url)")
            }
        }
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
