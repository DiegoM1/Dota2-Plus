//
//  HeroDetailViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 15/03/23.
//

import SwiftUI

class HeroDetailViewModel: ObservableObject {
    @Published var hero: HeroModel
    @Published var level = 1.0
    var str: String {
        String(Int(Double(hero.baseStr) + (hero.strGain * (level - 1))))
    }
    
    var agi: String {
        String(Int(Double(hero.baseAgi) + (hero.agiGain * (level - 1))))
    }
    
    var int : String {
        String(Int(Double(hero.baseInt) + (hero.intGain * (level - 1))))
    }
    
    var realArmor: String {
         String(format: "%.1f",hero.baseArmor + Double(hero.agiGain * (level - 1)) * 0.167)
    }
    
    var realHealth: String {
        String(Int(Double(hero.baseHealth) + ((Double(hero.baseStr) + (hero.strGain * (level - 1))) * 20.0)))
    }
    
    var realMana: String {
        String(Int(Double(hero.baseMana) + ((Double(hero.baseInt) + (hero.intGain * (level - 1))) * 12.0)))
    }
    
    init(hero: HeroModel) {
        self.hero = hero
    }
}
