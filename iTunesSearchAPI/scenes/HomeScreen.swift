//
//  HomeScreen.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection){
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(1)
            TopTen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(2)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
