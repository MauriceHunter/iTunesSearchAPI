//
//  TopTenModel.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 10/28/22.
//

import Foundation

struct TopMovies: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let entry: [Entry]
}

// MARK: - Entry
struct Entry: Codable {
    let imName: Icon
    let imImage: [IMImage]
    let summary: Icon
    let imPrice: IMPrice
    let link: [EntryLink]
    let id: ID
    let imArtist: Icon
    let category: Category
    
    enum CodingKeys: String, CodingKey {
            case imName = "im:name"
            case imImage = "im:image"
            case summary
            case imPrice = "im:price"
            case link
            case id
            case imArtist = "im:artist"
            case category
        }
}

// MARK: - Icon
struct Icon: Codable {
    let label: String
}

// MARK: - IMImage
struct IMImage: Codable {
    let label: String
    let attributes: IMImageAttributes
}

// MARK: - IMImageAttributes
struct IMImageAttributes: Codable {
    let height: String
}

// MARK: - IMPrice
struct IMPrice: Codable {
    let label: String
    let attributes: IMPriceAttributes
}

// MARK: - Category
struct Category: Codable {
    let attributes: CategoryAttributes
}

// MARK: - CategoryAttributes
struct CategoryAttributes: Codable {
    let label: String
}

// MARK: - ID
struct ID: Codable {
    let label: String
    let attributes: IDAttributes
}

// MARK: - IDAttributes
struct IDAttributes: Codable {
    let imID: String
    
    enum CodingKeys: String, CodingKey {
            case imID = "im:id"
        }
}

// MARK: - IMPriceAttributes
struct IMPriceAttributes: Codable {
    let amount: String
}

// MARK: - EntryLink
struct EntryLink: Codable {
    let attributes: PurpleAttributes
    let imDuration: Icon?
}

// MARK: - PurpleAttributes
struct PurpleAttributes: Codable {
    let href: String
}

// MARK: - FeedLink
struct FeedLink: Codable {
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Codable {
    let rel: String
    let href: String
}
