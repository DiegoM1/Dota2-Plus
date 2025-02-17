//
//  DotaApiService_unitTests.swift
//  Dota2 plusTests
//
//  Created by Diego Monteagudo Diaz on 17/03/23.
//

import XCTest
@testable import Dota2_plus

final class DotaApiService_unitTests: XCTestCase {
    var mockSession: MockURLSession!
    var service: DotaApiService!

    override func setUpWithError() throws {
        super.setUp()
        mockSession = MockURLSession()
        service = DotaApiService(urlSession: mockSession)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testFetchTeamData_ShouldReturnTrue() throws {
//
//        let request = Resource<[TeamModel]>(url: Constants.Urls.teams) { data in
//            let decoded = try? JSONDecoder().decode([TeamModel].self, from: data)
//            guard let decoded = decoded else {
//                return []
//            }
//            return decoded
//        }
//        let expectation = self.expectation(description: "ValidRequest_Returns_TeamResponse")
//
//        Task {
//            await dotaApiService.fetchData(request: request) { data in
//                if let result = data {
//                    XCTAssertTrue(!result.isEmpty)
//                    expectation.fulfill()
//                }
//            }
//        }
//        waitForExpectations(timeout: 10)
//    }
//
//
    func testFetchHeroData_ShouldReturnTrue() async throws {
        // Given
        if let url: URL = Bundle.main.url(forResource: "heroesServiceResponse", withExtension: "json") {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            mockSession.mockData = data
        }
        let request = Resource<[HeroModel]>(url: URL(string: "https://example.com")!) { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try? decoder.decode([HeroModel].self, from: data)
        }

        let expectation = expectation(description: "Fetching mock heroes")
        var result: [HeroModel]?

        // When
        await service.fetchData(request: request) { data in
            result = data
            expectation.fulfill()
        }

        // Then
        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(result?.count, 124)
        XCTAssertEqual(result?.first?.name, "npc_dota_hero_antimage")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
