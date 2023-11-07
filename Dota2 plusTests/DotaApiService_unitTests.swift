//
//  DotaApiService_unitTests.swift
//  Dota2 plusTests
//
//  Created by Diego Monteagudo Diaz on 17/03/23.
//

import XCTest
@testable import Dota2_plus

final class DotaApiService_unitTests: XCTestCase {
    var dotaApiService: DotaApiService!
    var teamResponse = [TeamModel]()
    var heroResponse = [HeroModel]()

    override func setUpWithError() throws {
        dotaApiService = DotaApiService(urlSession: .shared)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchTeamData_ShouldReturnTrue() throws {

        let request = Resource<[TeamModel]>(url: Constants.Urls.teams) { data in
            let decoded = try? JSONDecoder().decode([TeamModel].self, from: data)
            guard let decoded = decoded else {
                return []
            }
            return decoded
        }
        let expectation = self.expectation(description: "ValidRequest_Returns_TeamResponse")

        Task {
            await dotaApiService.fetchData(request: request) { data in
                if let result = data {
                    XCTAssertTrue(!result.isEmpty)
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testFetchHeroData_ShouldReturnTrue() throws {

        let request = Resource<[HeroModel]>(url: Constants.Urls.heroes) { data in
            let decoded = try? JSONDecoder().decode([HeroModel].self, from: data)
            guard let decoded = decoded else {
                return []
            }
            return decoded
        }
        let expectation = self.expectation(description: "ValidRequest_Returns_TeamResponse")

        Task {
            await dotaApiService.fetchData(request: request) { data in
                if let result = data {
                    XCTAssertTrue(result.isEmpty)
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
