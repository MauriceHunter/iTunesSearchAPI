//
//  SearchView.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import SwiftUI

struct SearchView: View {

    // TODO: these should be in a ViewModel
    @State private var results = [Result]()
    @State private var searchTerm = ""
    @State var newView = false
    @StateObject var movieIdDetailsForNewView = MovieIdDetails()
    
    // TODO like this other View, these views need the common UI Elements extracted.
    var body: some View {
            NavigationView{
                ScrollView{
                    ForEach(results, id: \.trackId){ item in
                        NavigationLink(destination: MovieDetail()){
                            VStack{
                                SearchViewImage(imageURL: item.artworkUrl100)
                                SearchViewDescriptiveInfo(genre: item.primaryGenreName, title: item.trackName, director: item.artistName, price: Double.doubleUnwrap(doubleOne: item.trackHdPrice, doubleTwo: item.trackPrice))
                            }
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1))
                            .padding([.top, .horizontal])
                        }
                        .simultaneousGesture(TapGesture().onEnded { movieIdDetailsForNewView.movieId = item.trackId
                        })
                    }
                }
                
                .task {
                    await loadData()
                }
                .searchable(text: $searchTerm)
                .onSubmit(of: .search){
                    Task{
                        await loadData()
                    }
                }
                
            }
            .environmentObject(movieIdDetailsForNewView)
        
    }

    class MovieIdDetails: ObservableObject{ //TODO - carefull of the spacing should be single spave befrore {
        @Published var movieId: Int = 0
    }

    //TODO: Move this into String+extension
    func noSpace(searchTerm: String) -> String{ //TODO - carefull of the spacing should be single spave befrore {
        let newTerm = searchTerm.replacingOccurrences(of: " ", with: "+")
        return newTerm
    }
    
    // TODO: Move this into the VM
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(noSpace(searchTerm: searchTerm))&entity=movie")
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
