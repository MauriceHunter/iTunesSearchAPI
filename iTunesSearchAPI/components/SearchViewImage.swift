//
//  SearchViewImage.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI


struct SearchViewImage: View {
    var imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL.replacingOccurrences(of: "100x100", with: "800x800"))) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Text("there was an error loading the image")
            } else {
                ProgressView()
            }
        }
    }
}

struct SearchViewImage_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewImage(imageURL: "https://iconsplace.com/wp-content/uploads/_icons/ffe500/256/png/error-icon-19-256.png")
    }
}
