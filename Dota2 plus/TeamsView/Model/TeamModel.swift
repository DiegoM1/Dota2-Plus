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
}
