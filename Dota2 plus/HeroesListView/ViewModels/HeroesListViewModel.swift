//
//  HeroesListViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

@MainActor
class HeroesListViewModel: ObservableObject {
    @Binding var heroList: [HeroModel]
    @Binding var favoriteHeroList: [HeroModel]
    @Published var heroesListFiltered: [HeroModel]
    @Published var filterActivated: AttributeType? = nil
    
    let userDefaults = UserDefaults.standard
    
    @Published var heroText = ""
    
    init(heroList: Binding<[HeroModel]>, favoriteHeroList: Binding<[HeroModel]>, filterActivated: AttributeType? = nil, heroText: String = "") {
        _heroList = heroList
        _favoriteHeroList = favoriteHeroList
        self.filterActivated = filterActivated
        self.heroText = heroText
        _heroesListFiltered = Published(initialValue: heroList.wrappedValue)
    }
    
    func filter(_ text: String){
        if text == "" {
            if let filterActivated = filterActivated {
                heroesListFiltered = heroList.filter{ $0.primaryAttribute == filterActivated}
            } else {
                heroesListFiltered = heroList
            }
        } else {
            heroesListFiltered = heroList.filter{ $0.localizedName.lowercased().contains(text.lowercased()) }
        }
    }
    
    func filterBy(atrribute: AttributeType) {
        if atrribute == filterActivated {
            heroesListFiltered = heroList
            filterActivated = nil
            return
        }
        filterActivated = atrribute
        heroesListFiltered = heroList.filter{ $0.primaryAttribute == atrribute }
    }
    
    func addOrRemoveFavoriteHero(_ hero: HeroModel) {
        if !favoriteHeroList.contains(where: { $0.id == hero.id }) {
            withAnimation() {
                favoriteHeroList.append(hero)
            }
            
            heroList.removeAll { $0.id == hero.id}
        } else {
            heroList.append(hero)
            heroList = heroList.sorted { $0.localizedName < $1.localizedName}
            
            withAnimation {
                favoriteHeroList.removeAll{ $0.id == hero.id}
            }
            
        }
    }
}
