//
//  HeroDetailService.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 21/03/23.
//

import Foundation

class HeroDetailService {
    var dotaService: DotaApiServiceProtocol
    private let fileName = "favoriteHeroes"
    
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
    
    func readFromFile(completion: @escaping ([HeroOrganizationModel]) -> ()) {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathExtension(fileName)
        
        guard let data = try? Data(contentsOf: path) else {
            return
        }
        if let decoded = try? JSONDecoder().decode([HeroOrganizationModel].self, from: data) {
            completion(decoded)
        }
    }
    
    func saveData(_ favorite: [HeroOrganizationModel]) async -> Bool {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathExtension(fileName)
        do {
            
         let data = try JSONEncoder().encode(favorite)
            try data.write(to: path)
            return true
         } catch {
             print(error)
             return false
         }
    }
}
