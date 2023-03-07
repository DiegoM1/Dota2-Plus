//
//  HeroesListViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

class HeroesListViewModel: ObservableObject {
    @Published var heroesListFiltered = [HeroModel]()
    @Published var filterActivated: AttributeType? = nil
    var heroesList: [HeroModel] = [] {
        didSet{
            heroesListFiltered = heroesList
        }
    }
    @Published var heroText = ""

    func fetchData() {
        DispatchQueue.main.async {
            Task {
                await DotaApiService().fetchHerosData(&self.heroesList)
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
            heroesListFiltered = heroesListFiltered.filter{ $0.localizedName.contains(text) }
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
