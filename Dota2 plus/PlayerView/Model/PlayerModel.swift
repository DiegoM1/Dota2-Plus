//
//  ItemModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 14/03/23.
//

import Foundation
struct PlayerModel: Codable {
    let mmrEstimate: [String: Int]?
    let rankTier: Int?
    let leaderboardRank: Int?
    var profile: ProfileModel?
}
struct ProfileModel: Codable {
    let accountId: Int
    let personaname: String
    let name: String?
    let plus: Bool
    let steamid: String
    let avatarfull: String
    let profileurl: String

}
