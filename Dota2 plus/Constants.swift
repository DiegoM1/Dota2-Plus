//
//  Constants.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation
private let baseStringUrl = "https://api.opendota.com"
private let iconBaseStringUrl = "https://cdn.cloudflare.steamstatic.com/"
struct Constants {
    struct Urls {
        static var heroes = URL(string: "\(baseStringUrl)/api/heroStats")!
        static var teams = URL(string: "\(baseStringUrl)/api/teams")!
        static var lore = URL(string: "\(baseStringUrl)/api/constants/hero_lore")!

        static func teamLogoUrlGenerator(_ id: Int) -> URL {
            return URL(string: "https://steamcdn-a.akamaihd.net/apps/dota2/images/team_logos/\(id).png?")!
        }

        static func heroLogoImage(_ name: String) -> URL {
            let name = name.replacingOccurrences(of: "npc_dota_hero_", with: "")
            return URL(string: "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/\(name).png?")!
        }

        static func heroIconImage(_ icon: String) -> URL {
            return URL(string: "\(iconBaseStringUrl)\(icon)")!
        }

        static func urlHeroLink(_ name: String) -> URL {
            var name = name.replacingOccurrences(of: "npc_dota_hero_", with: "")
            name = name.replacingOccurrences(of: " ", with: "")
            return URL(string: "https://www.dota2.com/hero/\(name)")!
        }

        static func urlPlayer(_ id: Int) -> URL {
            return URL(string: "\(baseStringUrl)/api/players/\(id)")!
        }
    }

}
