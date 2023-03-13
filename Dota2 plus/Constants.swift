//
//  Constants.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation

struct Constants {
    struct Urls {
        static var heroes = URL(string:"https://api.opendota.com/api/heroes")!
        static var teams = URL(string: "https://api.opendota.com/api/teams")!
        
        static func teamLogoUrlGenerator(_ id: Int) -> URL {
            return URL(string: "https://steamcdn-a.akamaihd.net/apps/dota2/images/team_logos/\(id).png?")!
        }
        
        static func heroLogoImage(_ name: String) -> URL {
            let name = name.replacingOccurrences(of: "npc_dota_hero_", with: "")
            return URL(string: "https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/\(name).png?")!
        }
        
        static func urlHeroLink(_ name: String) -> URL {
            let name = name.replacingOccurrences(of: "npc_dota_hero_", with: "")
            return URL(string: "https://www.dota2.com/hero/\(name)")!
        }
    }
    

}
