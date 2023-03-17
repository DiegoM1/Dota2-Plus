//
//  HeroTabBarViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 13/03/23.
//

import SwiftUI

class HeroTabBarViewModel: ObservableObject {
    var apiService: HeroTabBarService
    
    @Published var isLoading = true
    @Published var heroesListFiltered = [HeroOrganizationModel]()
    @Published var filterActivated: AttributeType? = nil
    @Published var heroText = ""
    @Published var favoriteHeroes = [HeroOrganizationModel]() {
        didSet {
            apiService.saveData(favoriteHeroes)
        }
    }
    
    let userDefaults = UserDefaults.standard
    
    var heroesList: [HeroOrganizationModel] = [] {
        didSet{
            DispatchQueue.main.async {
                self.heroesListFiltered = self.heroesList.sorted { $0.info.localizedName < $1.info.localizedName }
                self.heroesListFiltered = self.heroesListFiltered.filter { value in !self.favoriteHeroes.contains { $0.info.id == value.info.id } }
                
            }
            
        }
    }
    init(apiService: HeroTabBarService) {
        self.apiService = apiService
    }
    
    func fetchHeroesData() {
        
        apiService.readFromFile { data in
            self.favoriteHeroes = data
        }
        apiService.fetchData { data in
            self.heroesList = data
            self.isLoading = false
        }
    }
}
