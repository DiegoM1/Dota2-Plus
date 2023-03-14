//
//  HeroTabBarViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 13/03/23.
//

import SwiftUI

class HeroTabBarViewModel: ObservableObject {
    var apiService: DotaApiServiceProtocol
    @Published var heroesListFiltered = [HeroModel]()
    @Published var filterActivated: AttributeType? = nil
    @Published var favoriteHeroes = [HeroModel]() {
        didSet {
            let path = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask)[0].appendingPathExtension(fileName)
            do {
                
             let data = try JSONEncoder().encode(favoriteHeroes) 
                try data.write(to: path)
             } catch {
                 print(error)
             }
        }
    }
    
    private let fileName = "favoriteHeroes"
    let userDefaults = UserDefaults.standard
    
    var heroesList: [HeroModel] = [] {
        didSet{
            DispatchQueue.main.async {
                self.heroesListFiltered = self.heroesList.sorted { $0.localizedName < $1.localizedName}
            }
        }
    }
    @Published var heroText = ""
    
    init(apiService: DotaApiServiceProtocol) {
        self.apiService = apiService
    }
    
    
    func fetchData() {
        
        readFromFile()
        if heroesListFiltered.isEmpty {
            let resource = Resource<[HeroModel]>(url: Constants.Urls.heroes) { data in
                let decoded = try? JSONDecoder().decode([HeroModel].self, from: data)
                guard let decoded = decoded else {
                    return [HeroModel]()
                }
                
                return decoded
            }
            Task {
                await apiService.fetchData(request: resource) { data in
                    if let result = data {
                        self.heroesList = result.filter { value in !self.favoriteHeroes.contains { $0.id == value.id}}
                    }
                }
            }
        }
    }
    
    func readFromFile() {
        let path = FileManager.default.urls(for: .documentDirectory,
                                                  in: .userDomainMask)[0].appendingPathExtension(fileName)
        
        guard let data = try? Data(contentsOf: path) else {
            return
        }
        if let decoded = try? JSONDecoder().decode([HeroModel].self, from: data) {
            favoriteHeroes = decoded
        }
        
    }
    
}
