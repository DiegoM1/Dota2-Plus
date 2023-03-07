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
    }
    
    static func urlHeroLink(_ name: String) -> URL {
        return URL(string: "https://www.dota2.com/hero/\(name)")!
    }
}
