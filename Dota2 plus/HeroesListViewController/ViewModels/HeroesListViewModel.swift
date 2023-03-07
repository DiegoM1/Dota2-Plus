//
//  HeroesListViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI


class HeroesListViewModel: ObservableObject {
    var apiService: DotaApiServiceProtocol
    @Published var heroesListFiltered = [HeroModel]()
    @Published var filterActivated: AttributeType? = nil
    var heroesList: [HeroModel] = [] {
        didSet{
            DispatchQueue.main.async {
                self.heroesListFiltered = self.heroesList
            }
        }
    }
    @Published var heroText = ""
    
    init(apiService: DotaApiServiceProtocol) {
        self.apiService = apiService
    }
    
    
    func fetchData() {
        let resource = Resource<[HeroModel]>(url: Constants.Urls.heroes) { data in
            let decoded = try? JSONDecoder().decode([HeroModel].self, from: data)
            return decoded!
        }
        
        apiService.fetchData(request: resource) { data in
            if let result = data {
                self.heroesList = result
            }
        }
    }
    
    func filter(_ text: String){
        if text == "" {
            if let filterActivated = filterActivated {
                heroesListFiltered = heroesList.filter{ $0.primaryAttribute == filterActivated}
            } else {
                heroesListFiltered = heroesList
            }
        } else {
            heroesListFiltered = heroesList.filter{ $0.localizedName.lowercased().contains(text.lowercased()) }
        }
    }
    
    func filterBy(atrribute: AttributeType) {
        if atrribute == filterActivated {
            heroesListFiltered = heroesList
            filterActivated = nil
            return
        }
        filterActivated = atrribute
        heroesListFiltered = heroesList.filter{ $0.primaryAttribute == atrribute }
    }
}
