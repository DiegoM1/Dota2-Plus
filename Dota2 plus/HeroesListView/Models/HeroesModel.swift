//
//  HeroesListViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation
import SwiftUI

enum AttributeType: String, Codable {
    case agi, str, int, all
    
    func iconName() -> String {
        switch self {
        case .agi:
            return "AgilityAttributeSymbol"
        case .str:
            return "StrengthAttributeSymbol"
        case .int:
            return "IntelligenceAttributeSymbol"
        case .all:
            return "AllAttributeSymbol"
        }
    }
    
    func foregroundColor() -> Color {
        switch self {
        case .agi:
            return Color("GreenAgility")
        case .str:
            return Color("RedStrength")
        case .int:
            return Color("BlueIntelligence")
        case .all:
            return Color.yellow
        }
    }
}

enum RolesType: String, Codable {
    case carry = "Carry"
    case escape = "Escape"
    case nuker = "Nuker"
    case durable = "Durable"
    case disabler = "Disabler"
    case initiator = "Initiator"
    case support = "Support"
    case pusher = "Pusher"
}

enum AttackType: String, Codable {
    case meele = "Melee"
    case ranged = "Ranged"
}

struct HeroModel: Codable, Identifiable {
    var id: Int
    var name: String
    var localizedName: String
    var primaryAttr: AttributeType
    var attackType: AttackType
    var roles: [RolesType]
    var img: String
    var icon: String
    var baseHealth: Int
    var baseHealthRegen: Double
    var baseMana: Int
    var baseManaRegen: Double
    var baseArmor: Double
    var baseAttackMin: Int
    var baseAttackMax: Int
    var baseStr: Int
    var baseAgi: Int
    var baseInt: Int
    var strGain: Double
    var agiGain: Double
    var intGain: Double
    var attackRange: Int
    var projectileSpeed: Int
    var attackRate: Double
    var baseAttackTime: Int
    var attackPoint: Double
    var moveSpeed: Int
    var turnRate: Double?
    var cmEnabled: Bool
    var legs: Int
    var dayVision: Int
    var nightVision: Int
    var turboPicks: Int
    var turboWins: Int
    var proBan: Int
    var proWin: Int
    var proPick: Int
}
