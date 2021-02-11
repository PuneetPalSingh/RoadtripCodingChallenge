//
//  Songs.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import Foundation

struct Track: Codable {
    let trackId: String?
    let uri: String?
    let href: String?
    let type: String?
    let images: [Image]?
    let releaseDate: String?
    let name: String?
    var smallImageUrltring: String? {
        get {
            return images?[2].url ?? ""
        }
    }
    var mediumImageUrltring: String? {
        get {
            return images?[1].url ?? ""
        }
    }
    var largeImageUrltring: String? {
        get {
            return images?[0].url ?? ""
        }
    }
    var largeImage: Image?
    
    private enum CodingKeys: String, CodingKey {
        case trackId = "id"
        case uri = "uri"
        case href = "href"
        case type = "type"
        case images = "images"
        case releaseDate = "release_date"
        case name = "name"
    }
}
