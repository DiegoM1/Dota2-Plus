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
        heroTabBarViewModel = HeroTabBarViewModel(apiService: DotaApiService())
        if let path = Bundle.main.path(forResource: "heroesServiceResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path))
                let dataDecoded = try? JSONDecoder().decode([HeroModel].self, from: data)
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
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.randomElement()?.primaryAttribute, .agi)
    }
    
    func testAddOrRemoveFavoriteHero() throws {
        let testHero = HeroModel(id: 1, name: "TestHero", localizedName: "TestHero", primaryAttribute: .agi, attackType: .meele, roles: [.carry,.disabler])
        heroesListViewModel.addOrRemoveFavoriteHero(testHero)
        
        XCTAssertTrue(heroesListViewModel.heroList.contains{ $0.id == testHero.id})
        
        heroesGridCellsViewModel.addOrRemoveFavoriteHero(testHero)
        
        XCTAssertTrue(heroesGridCellsViewModel.heroList.contains{ $0.id == testHero.id})
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
