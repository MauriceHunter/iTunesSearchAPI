//
//  MovieDetailTrailer.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI
import AVKit

struct MovieDetailTrailer: View {
    
    var trailer: String
    
    var body: some View {
        Text("Trailer:")
            .font(.title)
            .fontWeight(.black)
        VideoPlayer(player: AVPlayer(url: URL(string: trailer)!))
            .frame(width: 300, height: 200)
            .shadow(color: .blue ,radius: 10)
            .padding()
    }
}

struct MovieDetailTrailer_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailTrailer(trailer: ".mp4")
    }
}
