//
//  DotaApiService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

protocol DotaApiServiceProtocol {
    func fetchData<T>(request: Resource<T>, completion: @escaping (T?) -> ()) async
}

class DotaApiService: DotaApiServiceProtocol {
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func fetchData<T>(request: Resource<T>, completion: @escaping (T?) -> ()) async {
        urlSession.dataTask(with: request.url) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(request.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
