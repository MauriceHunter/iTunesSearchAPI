//
//  TopTen.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import SwiftUI

//http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json


struct TopTen: View {

    let columns: [GridItem] = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]

    @StateObject var vm = TopTen.ViewModel()
    @StateObject var movieIdDetailsForNewView = MovieIdDetails() // TODO: move this into VM
    
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns){
                    ForEach(vm.topTenResults, id: \.id.attributes.imID) { result in
                        NavigationLink(destination: TopTenMovieDetail()){
                            VStack{
                                TopTenImage(imageURL: result.imImage.first?.label ?? "image")
                                Divider()
                                TopTenDescriptiveInfo(attributes: result.category.attributes.label, imName: result.imName.label, imArtist: result.imArtist.label, imPrice: result.imPrice.label)
                            }
                        }
                        .simultaneousGesture(TapGesture().onEnded { movieIdDetailsForNewView.movieId = Int.stringToInt(idString: result.id.attributes.imID)
                            print(result.id.label)
                        })
                    }
                    
                }
                .padding()
            }
            .task {
                await vm.loadData()
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
