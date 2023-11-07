//
//  HeroModelOrganization.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 17/03/23.
//

import Foundation

struct HeroOrganizationModel: Codable {
    var info: HeroData
    var healthStr: BaseHeroStatsStr
    var manaInt: BaseHeroStatsInt
    var armorAgi: BaseHeroStatsAgi
    var attack: AttackHero
    var movement: MovementHero
    var draft: PicksWinRateHero
    var vision: VisionHero
    var isFavorite: Bool = false
}

struct HeroData: Codable {
    var id: Int
    var name: String
    var localizedName: String
    var primaryAttr: AttributeType
    var attackType: AttackType
    var roles: [RolesType]
    var img: String
    var icon: String
}

struct  BaseHeroStatsStr: Codable {
    var baseHealth: Int
    var baseHealthRegen: Double
    var baseStr: Int
    var strGain: Double
}

struct BaseHeroStatsAgi: Codable {
    var baseArmor: Double
    var agiGain: Double
    var baseAgi: Int
}

struct BaseHeroStatsInt: Codable {
    var baseMana: Int
    var baseManaRegen: Double
    var baseInt: Int
    var intGain: Double
}

struct AttackHero: Codable {
    var baseAttackMin: Int
    var baseAttackMax: Int
    var attackRange: Int
    var projectileSpeed: Int
    var attackRate: Double
    var baseAttackTime: Int
    var attackPoint: Double
}

struct MovementHero: Codable {
    var speed: Int
    var turnRate: Double?
    var legs: Int
}

struct VisionHero: Codable {
    var dayVision: Int
    var nightVision: Int
}

struct PicksWinRateHero: Codable {
    var cmEnabled: Bool
    var turboPicks: Int
    var turboWins: Int
    var proBan: Int
    var proWin: Int
    var proPick: Int
}
