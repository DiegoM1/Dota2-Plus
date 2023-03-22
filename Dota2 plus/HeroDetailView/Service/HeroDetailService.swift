//
//  HeroDetailService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 21/03/23.
//

import Foundation

class HeroDetailService {
    var dotaService: DotaApiServiceProtocol
    
    init(dotaService: DotaApiServiceProtocol) {
        self.dotaService = dotaService
    }
    
    func fetchData(completion: @escaping ([String: String]) -> ()) {
        let resource = Resource<[String: String]>(url: Constants.Urls.lore) { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let data = try decoder.decode([String: String].self, from: data)
                return data
            }catch {
                print(error)
            }
            
            return nil
        }
        Task {
            await dotaService.fetchData(request: resource) { data in
                if let result = data {
                    completion(result)
                }
            }
        }
    }
}
