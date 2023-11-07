//
//  HeroTabBarService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 16/03/23.
//

import SwiftUI

class HeroTabBarService {
    var dotaService: DotaApiServiceProtocol

    init(dotaService: DotaApiServiceProtocol) {
        self.dotaService = dotaService
    }

    func fetchData(completion: @escaping ([HeroOrganizationModel]) -> Void) {
        let resource = Resource<[HeroModel]>(url: Constants.Urls.heroes) { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode([HeroModel].self, from: data)
                return data
            } catch {
                print(error)
            }

            return nil
        }
        Task {
            await dotaService.fetchData(request: resource) { data in
                if let result = data {

                    completion(self.heroModelOrganizationConstructo(result))
                }
            }
        }
    }

    func heroModelOrganizationConstructo(_ heroesModel: [HeroModel]) -> [HeroOrganizationModel] {
        return heroesModel.map { HeroOrganizationModel(info: HeroData(id: $0.id
                                                                      , name: $0.name,
                                                                      localizedName: $0.localizedName,
                                                                      primaryAttr: $0.primaryAttr,
                                                                      attackType: $0.attackType, roles: $0.roles
                                                                      , img: $0.img,
                                                                      icon: $0.icon),
                                                       healthStr: BaseHeroStatsStr(baseHealth: $0.baseHealth,
                                                                                   baseHealthRegen: $0.baseHealthRegen,
                                                                                   baseStr: $0.baseStr,
                                                                                   strGain: $0.strGain),
                                                       manaInt: BaseHeroStatsInt(baseMana: $0.baseMana,
                                                                                 baseManaRegen: $0.baseManaRegen,
                                                                                 baseInt: $0.baseInt,
                                                                                 intGain: $0.intGain),
                                                       armorAgi: BaseHeroStatsAgi(baseArmor: $0.baseArmor,
                                                                                  agiGain: $0.agiGain,
                                                                                  baseAgi: $0.baseAgi),
                                                       attack: AttackHero(baseAttackMin: $0.baseAttackMin,
                                                                          baseAttackMax: $0.baseAttackMax,
                                                                          attackRange: $0.attackRange,
                                                                          projectileSpeed: $0.projectileSpeed,
                                                                          attackRate: $0.attackRate,
                                                                          baseAttackTime: $0.baseAttackTime,
                                                                          attackPoint: $0.attackPoint),
                                                       movement: MovementHero(speed: $0.moveSpeed,
                                                                              legs: $0.legs), draft: PicksWinRateHero(cmEnabled: $0.cmEnabled, turboPicks: $0.turboPicks, turboWins: $0.turboWins, proBan: $0.proBan, proWin: $0.proWin, proPick: $0.proPick), vision: VisionHero(dayVision: $0.dayVision, nightVision: $0.nightVision))}
    }
}
