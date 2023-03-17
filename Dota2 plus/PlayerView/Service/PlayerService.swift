//
//  PlayerService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 16/03/23.
//

import Foundation

class PlayerService {
    var service: DotaApiServiceProtocol
    
    init(service: DotaApiServiceProtocol) {
        self.service = service
    }
    
    
    func fetchData(_ id: Int, completion: @escaping (PlayerModel) -> ()) {
        let resource = Resource(url: Constants.Urls.urlPlayer(id)) { data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(PlayerModel.self, from: data)
                return data
            } catch {
                print(error)
            }
            
            return nil
        }
        
        
        Task {
           await service.fetchData(request: resource) { data in
                if let data = data {
                    completion(data)
                }
            }
        }
    }
}
