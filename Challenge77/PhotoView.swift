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
            Image("\(photo.id)")
                .resizable()
                .scaledToFit()
            Text("\(photo.name)")
            Spacer()
        }
        .padding()
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo.example)
    }
}
