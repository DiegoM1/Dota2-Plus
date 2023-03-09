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
    func fetchData<T>(request: Resource<T>, completion: @escaping (T?) -> ()) async {
        URLSession.shared.dataTask(with: request.url) { data, response, error in
            
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
