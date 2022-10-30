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
                                AsyncImage(url: URL(string: item.artworkUrl100.replacingOccurrences(of: "100x100", with: "800x800"))) { phase in
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
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(item.primaryGenreName)
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                        Text(item.trackName)
                                            .font(.title)
                                            .fontWeight(.black)
                                            .foregroundColor(.primary)
                                            .lineLimit(3)
                                            .onTapGesture {
                                                print(item.artworkUrl100)
                                            }
                                        Text("Directed by \(item.artistName)".uppercased())
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text("$\(Double.doubleUnwrap(doubleOne: item.trackHdPrice, doubleTwo: item.trackPrice), specifier: "%.2f")")
                                        
                                    }
                                    .layoutPriority(100)
                                    .padding(2)
                                    Spacer()
                                }
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
