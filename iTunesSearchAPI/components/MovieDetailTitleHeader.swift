//
//  MovieDetailTitleHeader.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI

struct MovieDetailTitleHeader: View {
    
    var title: String
    var director: String
    
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.black)
        Text("Directed by \(director)".uppercased())
            .font(.caption)
    }
}

struct MovieDetailTitleHeader_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailTitleHeader(title: "Scream", director: "Wes Craven")
    }
}
