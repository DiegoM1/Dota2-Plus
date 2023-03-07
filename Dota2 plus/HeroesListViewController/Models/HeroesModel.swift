//
//  HeroesListViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation
import SwiftUI

enum AttributeType: String, Decodable {
    case agi, str, int
    
    func iconName() -> String {
        switch self {
        case .agi:
            return "AgilityAttributeSymbol"
        case .str:
            return "StrengthAttributeSymbol"
        case .int:
            return "IntelligenceAttributeSymbol"
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
        }
    }
}

enum AttackType: String, Decodable {
    case meele = "Melee"
    case ranged = "Ranged"
}

struct HeroModel: Decodable, Identifiable {
    var id: Int
    var localizedName: String
    var primaryAttribute: AttributeType
    var attackType: AttackType
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case localizedName = "localized_name"
        case primaryAttribute = "primary_attr"
        case attackType = "attack_type"
    }
}
