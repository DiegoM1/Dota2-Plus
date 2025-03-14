//
//  HeroDetailViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 15/03/23.
//

import SwiftUI
@MainActor
class HeroDetailViewModel: ObservableObject {
    @Published var hero: HeroOrganizationModel
    @Published var level = 1.0
    @Published var loreHolder: String = ""
    @Published var isFavoriteHero = false
    @Published var showLore = false

    var favoritesHolder = [HeroOrganizationModel]()
    var apiService: HeroDetailService

    init(apiService: HeroDetailService, hero: HeroOrganizationModel ) {
        self.apiService = apiService
        self.hero = hero
    }

    var str: String {
        String(Int(Double(hero.healthStr.baseStr) + (hero.healthStr.strGain * (level - 1))))
    }

    var agi: String {
        String(Int(Double(hero.armorAgi.baseAgi) + (hero.armorAgi.agiGain * (level - 1))))
    }

    var int: String {
        String(Int(Double(hero.manaInt.baseInt) + (hero.manaInt.intGain * (level - 1))))
    }

    var realArmor: String {
         String(format: "%.1f", hero.armorAgi.baseArmor + Double(hero.armorAgi.agiGain * (level - 1)) * 0.167)
    }

    var realHealth: String {
        String(Int(Double(hero.healthStr.baseHealth) + ((Double(hero.healthStr.baseStr) + (hero.healthStr.strGain * (level - 1))) * 20.0)))
    }

    var realMana: String {
        String(Int(Double(hero.manaInt.baseMana) + ((Double(hero.manaInt.baseInt) + (hero.manaInt.intGain * (level - 1))) * 12.0)))
    }

    var proWinratePercentage: String {
        let winrate = Double(hero.draft.proWin) * 100.00 / Double(hero.draft.proPick)
        return String(format: "%.2f", winrate)
    }

    var turboWinratePercentage: String {
        let winrate = Double(hero.draft.turboWins) * 100.00 / Double(hero.draft.turboPicks)
        return String(format: "%.2f", winrate)
    }

    func fetchHeroData() {
        apiService.readFromFile { data in
            self.favoritesHolder = data
            self.isFavoriteHero = data.contains { $0.info.id == self.hero.info.id }
        }

        let name = hero.info.name.replacingOccurrences(of: "npc_dota_hero_", with: "")
        apiService.fetchData { data in
            guard let lore = data[name] else {
                return
            }
            self.loreHolder = lore
        }
    }

    func addOrRemoveFavoriteHero() async {
        if isFavoriteHero {
            favoritesHolder.removeAll { $0.info.id == hero.info.id }
            let value = await apiService.saveData(favoritesHolder)
            if value {
                isFavoriteHero = false
            } else {
                isFavoriteHero = true
            }
        } else {
            favoritesHolder.append(hero)
            let value = await apiService.saveData(favoritesHolder)
            if value {
                isFavoriteHero = true
            } else {
                isFavoriteHero = false
            }
        }
    }
}
