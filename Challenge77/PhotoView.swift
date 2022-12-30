//
//  PhotoView.swift
//  Challenge77
//
//  Created by Michael Rowe on 12/29/22.
//

import SwiftUI

struct PhotoView: View {
    let photo: Photo

    var body: some View {
        VStack {
            // Need to figure out how to reference the file name at the URL

            displayImage(imageNamed: "\(photo.id)")
                .resizable()
                .scaledToFit()
            Text("\(photo.name)")
            Spacer()
        }
        .padding()
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
