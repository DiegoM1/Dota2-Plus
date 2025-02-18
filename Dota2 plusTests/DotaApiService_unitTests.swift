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

    func testFetchTeamData_ShouldReturnTrue() async throws {
        if let url: URL = Bundle.main.url(forResource: "teamsServiceResponse", withExtension: "json") {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            mockSession.mockData = data
        }

        let request = Resource<[TeamModel]>(url: URL(string: "https://example.com")!) { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try? decoder.decode([TeamModel].self, from: data)
        }

        let expectation = expectation(description: "Fetching mock teams")
        var result: [TeamModel]?

        // When
        await service.fetchData(request: request) { data in
            result = data
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(result?.count, 19)
        XCTAssertEqual(result?.first?.teamId, 8291895)
        XCTAssertEqual(result?.last?.wins, 415)
        XCTAssertEqual(result?.last?.logoUrl, "https://steamusercontent-a.akamaihd.net/ugc/2028347991408203552/8DC9872DA88071D728A914CE17279959423FA340/")

    }

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
