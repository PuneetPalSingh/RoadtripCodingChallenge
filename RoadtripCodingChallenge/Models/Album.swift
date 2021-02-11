//
//  Album.swift
//  RoadtripCodingChallenge
//
//  Created by Puneet Pal Singh on 11/24/20.
//

import Foundation

struct Album: Codable {
    let href: String?
    let offset: Int64?
    let limit: Int64?
    let total: Int64?
    let items: [Track]?
}
