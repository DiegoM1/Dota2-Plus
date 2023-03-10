//
//  Dota2_plusTests.swift
//  Dota2 plusTests
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import XCTest
@testable import Dota2_plus

final class Dota2_plusTests: XCTestCase {
    var heroesListViewModel: HeroesListViewModel!
    override func setUpWithError() throws {
        heroesListViewModel = HeroesListViewModel(apiService: DotaApiService())
        if let path = Bundle.main.path(forResource: "heroesServiceResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path))
                let dataDecoded = try? JSONDecoder().decode([HeroModel].self, from: data)
                heroesListViewModel.heroesList = dataDecoded ?? [HeroModel]()
            } catch {
                print(error)
            }
        }
    }

    override func tearDownWithError() throws {
        heroesListViewModel = nil
    }

    func testFetchDataCorrectly() throws {
        XCTAssertTrue(heroesListViewModel.heroesList.count > 0)
    }
    
    func testFilterByText() throws {
        heroesListViewModel.filter("an")
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.first?.localizedName, "Anti-Mage")
    }
    
    func testFilterByAttribute() throws {
        heroesListViewModel.filterBy(atrribute: .agi)
        XCTAssertEqual(heroesListViewModel.heroesListFiltered.randomElement()?.primaryAttribute, .agi)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
