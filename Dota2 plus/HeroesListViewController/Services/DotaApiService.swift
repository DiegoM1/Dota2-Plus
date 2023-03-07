//
//  DotaApiService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import Foundation

class DotaApiService {
    
    func fetchHerosData(_ heroesList: inout [HeroModel]) async {
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: Constants.Urls.heroes))
            let heroesListData = try! JSONDecoder().decode([HeroModel].self, from: data)
                heroesList = heroesListData
        }
        catch {
            print(error)
            heroesList = [HeroModel]()
        }
    }
}
