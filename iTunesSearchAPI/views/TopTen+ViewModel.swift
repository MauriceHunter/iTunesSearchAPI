//
//  TopTen+ViewModel.swift
//  iTunesSearchAPI
//
//  Created by Sunjay Kalsi on 29/10/2022.
//

import SwiftUI

extension TopTen {
    public func stringToInt(idString: String) -> Int {
        let convertedString = Int(idString)

        if convertedString != nil {
            return convertedString!
        } else {
            return 404
        }
    }

    public func loadData() async {
        guard let url = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/topMovies/json")
        else {
            print("URL Issue")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(TopMovies.self, from: data)
            topTenResults = decodedResponse.feed.entry.self
        } catch {
            print(error)
        }
    }

}
