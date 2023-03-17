//
//  Dota2_plusTests.swift
//  Dota2 plusTests
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import XCTest
import SwiftUI
@testable import Dota2_plus

@MainActor  final class Dota2_plusTests: XCTestCase {
    var heroTabBarViewModel: HeroTabBarViewModel!
    var heroesListViewModel: HeroesListViewModel!
    var heroesGridCellsViewModel : HeroesGridCellsViewModel!
    
    override func setUpWithError() throws {
        heroTabBarViewModel = HeroTabBarViewModel(apiService: DotaApiService(urlSession: .shared))
        if let path = Bundle.main.path(forResource: "heroesServiceResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path))
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataDecoded = try? jsonDecoder.decode([HeroModel].self, from: data)
                heroTabBarViewModel.heroesList = dataDecoded ?? [HeroModel]()
            } catch {
                print(error)
            }
        }
        heroesGridCellsViewModel = HeroesGridCellsViewModel(heroList: .constant(heroTabBarViewModel.heroesList), favoriteHeroList: .constant(heroTabBarViewModel.favoriteHeroes))
        heroesListViewModel = HeroesListViewModel(heroList: .constant(heroTabBarViewModel.heroesList), favoriteHeroList: .constant(heroTabBarViewModel.favoriteHeroes))
    }

    func testFetchDataCorrectly() throws {
        XCTAssertTrue(heroTabBarViewModel.heroesList.count > 0)
    }
    
    func testFilterByText() throws {
        heroesListViewModel.filter("an")
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.first?.localizedName, "Anti-Mage")
    }
    
    func testFilterByAttribute() throws {
        heroesListViewModel.filterBy(atrribute: .agi)
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.randomElement()?.primaryAttr, .agi)
    }
    
    func testAddOrRemoveFavoriteHero() throws {
        let testHero = HeroModel(id: 1, name: "npc_dota_hero_antimage",
                                 localizedName: "Anti-Mage",
                                 primaryAttr: .agi,
                                 attackType: .meele,
                                 roles: [.carry,.escape,.nuker],
                                 img: "/apps/dota2/images/dota_react/heroes/antimage.png?",
                                 icon: "/apps/dota2/images/dota_react/heroes/icons/antimage.png?",
                                 baseHealth: 200,
                                 baseHealthRegen:
                                   0.25,
                                 baseMana: 75,
                                 baseManaRegen: 0,
                                 baseArmor: 0,
                                 baseAttackMin: 29,
                                 baseAttackMax: 33,
                                 baseStr: 21,
                                 baseAgi: 24,
                                 baseInt: 12,
                                 strGain: 1.6,
                                 agiGain: 2.8,
                                 intGain: 1.8,
                                 attackRange: 150,
                                 projectileSpeed: 0,
                                 attackRate: 1.4,
                                 baseAttackTime: 100,
                                 attackPoint: 0.3,
                                 moveSpeed: 310, cmEnabled: true, legs: 2, dayVision: 1800, nightVision: 800, turboPicks: 371300, turboWins: 202315, proBan: 194, proWin: 37, proPick: 80)
        
        heroesListViewModel.addOrRemoveFavoriteHero(testHero)
        
        XCTAssertTrue(heroesListViewModel.heroList.contains{ $0.id == testHero.id })
        
        heroesGridCellsViewModel.addOrRemoveFavoriteHero(testHero)
        
        XCTAssertTrue(heroesGridCellsViewModel.heroList.contains{ $0.id == testHero.id })
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
