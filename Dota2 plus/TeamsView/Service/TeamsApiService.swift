//
//  TeamsApiService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 8/03/23.
//

import Foundation

class TeamsApiService {
    var service: DotaApiService

    init(service: DotaApiService) {
        self.service = service
    }

    func fetchTeamData(completion: @escaping ([TeamModel]) -> Void) {
        let request = Resource<[TeamModel]>(url: Constants.Urls.teams) { data in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try? jsonDecoder.decode([TeamModel].self, from: data)
            guard let decoded = decoded else {
                return []
            }
            return decoded
        }

        Task {
            await service.fetchData(request: request) { data in
                if var result = data {
                    result.removeAll { $0.name == "" }
                    result.removeAll { $0.name.contains("CyberBonch")}
                    completion(Array(result.prefix(100)))
                }
            }
        }
    }
}
