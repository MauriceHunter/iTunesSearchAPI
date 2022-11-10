//
//  MovieDetail.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import SwiftUI
import AVKit

struct MovieDetail: View {
    
    @EnvironmentObject var detailedId: SearchView.MovieIdDetails
    @State private var results = [Result]()
    
    var body: some View {
        ScrollView{
            ForEach(results, id: \.trackId){ item in
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            MovieDetailTitleHeader(title: item.trackName, director: item.artistName)
                            Divider()
                            MovieDetailImage(imageURL: item.artworkUrl100)
                            
                        }
                        Spacer()
                        MovieDetailDescriptiveInfo(price: Double.doubleUnwrap(doubleOne: item.trackHdPrice, doubleTwo: item.trackPrice), rating: item.contentAdvisoryRating, runtime: item.trackTimeMillis)
                    }
                    Divider()
                    HStack{
                        VStack(alignment: .leading){
                            MovieDetailTrailer(trailer: item.previewUrl ?? ".mp4")
                            Divider()
                            MovieDetailSummary(description: item.longDescription)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .task {
            await loadData()
        }
    }

    //TODO cut this url if its not being used
    //https://itunes.apple.com/lookup?id=
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(detailedId.movieId)")
        else {
            print("URL Issue")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
            results = decodedResponse.results
        } catch {
            print(error)
        }
    }
}



struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail()
    }
}
