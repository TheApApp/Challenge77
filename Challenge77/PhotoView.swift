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
        guard let displayImage = UIImage(contentsOfFile: imageNamed) else { return Image(systemName: "nosign")}
        print("\(displayImage.description)")
        return Image(uiImage: displayImage)
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo.example)
    }
}
