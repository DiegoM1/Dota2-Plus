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
        let heroTabBarService = HeroTabBarService(dotaService: DotaApiService(urlSession: .shared))
        heroTabBarViewModel = HeroTabBarViewModel(apiService: heroTabBarService)
        if let path = Bundle.main.path(forResource: "heroesServiceResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path))
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataDecoded = try? jsonDecoder.decode([HeroModel].self, from: data)
                heroTabBarViewModel.heroesList = heroTabBarViewModel.apiService.heroModelOrganizationConstructo(dataDecoded ?? [HeroModel]())
            } catch {
                print(error)
            }
        }
        heroesGridCellsViewModel = HeroesGridCellsViewModel(heroList: .constant(heroTabBarViewModel.heroesList), favoriteHeroList: .constant(heroTabBarViewModel.favoriteHeroes))
        heroesListViewModel = HeroesListViewModel(heroList: .constant(heroTabBarViewModel.heroesList), favoriteHeroList: .constant(heroTabBarViewModel.favoriteHeroes))
        
    }

    func testFetchDataCorrectly_ShouldReturnTrue() throws {
        XCTAssertTrue(heroTabBarViewModel.heroesList.count > 0)
    }
    
    func testFilterByText_ShouldReturnEqual() throws {
        heroesListViewModel.filter("an")
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.first?.info.localizedName, "Anti-Mage")
    }
    
    func testFilterByAttribute_ShouldReturnEqual() throws {
        heroesListViewModel.filterBy(atrribute: .agi)
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.randomElement()?.info.primaryAttr, .agi)
    }
    
    func testAddOrRemoveFavoriteHero_ShouldReturnTrue() throws {
        guard let  testHero = heroTabBarViewModel.heroesList.first else {
            return
        }
        heroesListViewModel.addOrRemoveFavoriteHero(testHero)
        
        XCTAssertTrue(heroesListViewModel.heroList.contains{ $0.info.id == testHero.info.id })
        
        heroesGridCellsViewModel.addOrRemoveFavoriteHero(testHero)
        
        XCTAssertTrue(heroesGridCellsViewModel.heroList.contains{ $0.info.id == testHero.info.id })
    }
    
    func testFetchFromFileHeroData_ShouldReturnTrue() throws {
        guard let last = heroTabBarViewModel.heroesList.last else {
            return
        }
        heroTabBarViewModel.favoriteHeroes.append(last)
        Task {
            await heroTabBarViewModel.fetchFromFileHeroesData()
        }
        XCTAssertTrue(!heroTabBarViewModel.favoriteHeroes.isEmpty)
    }
    
    func testFetchFromFileHeroData_ShouldReturnFalse() throws {
        Task {
            await heroTabBarViewModel.fetchFromFileHeroesData()
        }
        XCTAssertFalse(!heroTabBarViewModel.favoriteHeroes.isEmpty)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
