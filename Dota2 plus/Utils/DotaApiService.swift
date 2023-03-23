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
    func readFromFile(completion: @escaping ([HeroOrganizationModel]) -> ())
    func saveData(_ favorite: [HeroOrganizationModel])
}

class DotaApiService: DotaApiServiceProtocol {
    let urlSession: URLSession
    private let fileName = "favoriteHeroes"
    
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
    
    func saveData(_ favorite: [HeroOrganizationModel]) {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathExtension(fileName)
        do {
            
         let data = try JSONEncoder().encode(favorite)
            try data.write(to: path)
         } catch {
             print(error)
         }
    }
}
