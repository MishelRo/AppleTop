//
//  Model.swift
//  probeGenerics
//
//  Created by User on 14.12.2020.
//
import Foundation
protocol Interface {
    var artistName : String? {get}
    var name : String? {get}
    var artistURL : String? {get}
    var artworkUrl100 : String? {get}
    var url: String? {get}
    
}

// MARK: - Welcome
struct ModelInfo: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable, Interface {
    let artistName, id: String?
    let releaseDate: String?
    let name, collectionName: String?
    let copyright, artistID: String?
    let artistURL: String?
    let artworkUrl100: String?
    let url: String?
    let contentAdvisoryRating: ContentAdvisoryRating?

    enum CodingKeys: String, CodingKey {
        case artistName, id, releaseDate, name, collectionName,  copyright
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100,  url, contentAdvisoryRating
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explicit = "Explicit"
}
