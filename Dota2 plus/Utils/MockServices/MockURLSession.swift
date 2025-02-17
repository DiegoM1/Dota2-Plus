//
//  MockURLSession.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 17/02/25.
//

import Foundation

/// Mock URLSession for testing network requests
class MockURLSession: URLSession {
    var mockData: Data?
    var mockError: Error?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = MockURLSessionDataTask {
            completionHandler(self.mockData, nil, self.mockError)
        }
        return task
    }
}

/// Mock URLSessionDataTask
class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
