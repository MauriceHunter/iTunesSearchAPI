//
//  TopTen.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import SwiftUI

//http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json


struct TopTen: View {
    
    @State public var topTenResults = [Entry]()
    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]
    
    @StateObject var movieIdDetailsForNewView = MovieIdDetails()
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(topTenResults, id: \.id.attributes.imID) { result in
                        NavigationLink(destination: TopTenMovieDetail()){
                            VStack{
                                AsyncImage(url: URL(string: result.imImage.first?.label.replacingOccurrences(of: "39x60", with: "400x400").replacingOccurrences(of: "113x170", with: "400x400") ?? "https://iconsplace.com/wp-content/uploads/_icons/ffe500/256/png/error-icon-19-256.png")){ phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } else if phase.error != nil {
                                        Text("there was an error loading the image")
                                    } else {
                                        ProgressView()
                                    }
                                }
                                Divider()
                                HStack{
                                    VStack(alignment: .leading){
                                        Text(result.category.attributes.label)
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                        Text(result.imName.label)
                                            .font(.title)
                                            .fontWeight(.black)
                                            .foregroundColor(.primary)
                                            .lineLimit(3)
                                        Text("Directed by \(result.imArtist.label)".uppercased())
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text("\(result.imPrice.label)")
                                    }
                                    .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded { movieIdDetailsForNewView.movieId = stringToInt(idString: result.id.attributes.imID)
                            print(result.id.label)
                        })
                    }
                    
                }
                .padding()
            }
            .task {
                await loadData()
            }
            .navigationTitle("iTunes Top 10 Movies")
            .navigationBarTitleDisplayMode(.inline)

        }
        
        .environmentObject(movieIdDetailsForNewView)
    }
    
    class MovieIdDetails: ObservableObject{
        @Published var movieId: Int = 0
    }
    
}

struct TopTen_Previews: PreviewProvider {
    static var previews: some View {
        TopTen()
    }
}
