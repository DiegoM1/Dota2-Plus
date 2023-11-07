//
//  TeamModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 8/03/23.
//

import Foundation

struct TeamModel: Codable {
    var teamId: Int
    var position: String?
    var rating: Double
    var wins: Int
    var losses: Int
    var lastMatchTime: Int
    var name: String
    var tag: String
    var logoUrl: String?

    enum CodingKeys: String, CodingKey {
        case position = "position"
        case teamId = "team_id"
        case rating = "rating"
        case wins = "wins"
        case losses = "losses"
        case lastMatchTime = "last_match_time"
        case name = "name"
        case tag = "tag"
        case logoUrl = "logo_url"
    }
}
