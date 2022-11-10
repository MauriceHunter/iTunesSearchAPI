//
//  TopTenDescriptiveInfo.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI

struct TopTenDescriptiveInfo: View {
    
    var attributes: String
    var imName: String
    var imArtist: String
    var imPrice: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(attributes)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(imName)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                Text("Directed by \(imArtist)".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("$\(String(describing: imPrice.dropFirst()))", comment: "top ten currency symbol")
            }
            .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

struct TopTenDescriptiveInfo_Previews: PreviewProvider {
    static var previews: some View {
        TopTenDescriptiveInfo(attributes: "Action & Adventure", imName: "Top Gun: Maverick", imArtist: "Joseph Kosinski", imPrice: "14.99")
    }
}
