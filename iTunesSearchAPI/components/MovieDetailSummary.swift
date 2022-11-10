//
//  MovieDetailSummary.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI

struct MovieDetailSummary: View {
    
    var description: String
    
    var body: some View {
        Text("Description:")
            .font(.title)
            .fontWeight(.black)
        Text(description)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct MovieDetailSummary_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailSummary(description: "description")
    }
}
