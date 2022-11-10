//
//  SearchViewDescriptiveInfo.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI

struct SearchViewDescriptiveInfo: View {
    var genre: String
    var title: String
    var director: String
    var price: Double?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(genre)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(title)
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                Text("Directed by \(director)".uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("$\(Double.doubleUnwrap(doubleOne: price, doubleTwo: price), specifier: "%.2f")")
                
            }
            .layoutPriority(100)
            .padding(2)
            Spacer()
        }
    }
}

struct SearchViewDescriptiveInfo_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewDescriptiveInfo(genre: "Horror", title: "Scream", director: "Wes Craven", price: Double.doubleUnwrap(doubleOne: 10.00, doubleTwo: 11.11))
    }
}
