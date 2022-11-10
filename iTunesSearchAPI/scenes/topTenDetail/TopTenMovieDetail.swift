//
//  TopTenMovieDetail.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import SwiftUI
import AVKit

struct TopTenMovieDetail: View {
    
    @EnvironmentObject var detailedId: TopTen.MovieIdDetails
    @State private var results = [Result]()

    // TODO: We need to break out the View below into SubViews where it makes sense so we can have some re-use
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
                        MovieDetailDescriptiveInfo(price: Double.doubleUnwrap(doubleOne: item.trackHdPrice, doubleTwo: item.trackPrice), rating: item.contentAdvisoryRating, runtime: item.trackTimeMillis)                    }
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

    //https://itunes.apple.com/lookup?id=
    // TODO: move this func to the Viewmodel
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

struct TopTenMovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail()
    }
}

