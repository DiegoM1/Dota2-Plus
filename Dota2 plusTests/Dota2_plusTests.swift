//
//  Dota2_plusTests.swift
//  Dota2 plusTests
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import XCTest
@testable import Dota2_plus

final class Dota2_plusTests: XCTestCase {
    var herosListViewModel: HeroesListViewModel!
    override func setUpWithError() throws {
        herosListViewModel = HeroesListViewModel(apiService: DotaApiService())
        if let path = Bundle.main.path(forResource: "heroesServiceResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path))
                let dataDecoded = try? JSONDecoder().decode([HeroModel].self, from: data)
                herosListViewModel.heroesList = dataDecoded ?? [HeroModel]()
            } catch {
                print(error)
            }
        }
    }

    override func tearDownWithError() throws {
        herosListViewModel = nil
    }

    func testFetchDataCorrectly() throws {
        XCTAssertTrue(herosListViewModel.heroesList.count > 0)
    }
    
    func testFilterByText() throws {
        herosListViewModel.filter("an")
        XCTAssertEqual(herosListViewModel.heroesListFiltered.first?.localizedName, "Anti-Mage")
    }
    
    func testFilterByAttribute() throws {
        herosListViewModel.filterBy(atrribute: .agi)
        XCTAssertEqual(herosListViewModel.heroesListFiltered.randomElement()?.primaryAttribute, .agi)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
