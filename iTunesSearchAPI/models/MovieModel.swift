//
//  MovieModel.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import Foundation

struct Response: Codable {
    let results: [Result]
}

struct Result: Codable{
    let trackId: Int
    let artistName: String
    let trackName: String
    let collectionViewUrl: String? //the preview page
    let previewUrl: String?
    let artworkUrl60: String
    let artworkUrl100: String
    let trackPrice: Double?
    let trackHdPrice: Double?
    let releaseDate: String
    let trackTimeMillis: Int?
    let primaryGenreName: String
    let contentAdvisoryRating: String
    let longDescription: String
    let trackViewUrl: String
}
