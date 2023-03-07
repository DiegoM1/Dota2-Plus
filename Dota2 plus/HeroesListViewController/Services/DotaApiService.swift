//
//  DotaApiService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation

protocol DotaApiServiceProtocol {
    func fetchHerosData(_ completion: @escaping ([HeroModel]?) -> ()) async
}

class DotaApiService: DotaApiServiceProtocol {
    func fetchHerosData(_ completion: @escaping ([HeroModel]?) -> ()) async {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: Constants.Urls.heroes))
            let heroesListData = try! JSONDecoder().decode([HeroModel].self, from: data)
            completion(heroesListData)
        }
        catch {
            print(error)
            completion(nil)
        }
    }
}
