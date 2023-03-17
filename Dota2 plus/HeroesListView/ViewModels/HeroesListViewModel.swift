//
//  HeroesListViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

@MainActor
class HeroesListViewModel: ObservableObject {
    @Binding var heroList: [HeroOrganizationModel]
    @Binding var favoriteHeroList: [HeroOrganizationModel]
    @Published var heroesListFiltered: [HeroOrganizationModel]
    @Published var filterActivated: AttributeType? = nil
    
    let userDefaults = UserDefaults.standard
    
    @Published var heroText = ""
    
    init(heroList: Binding<[HeroOrganizationModel]>, favoriteHeroList: Binding<[HeroOrganizationModel]>, filterActivated: AttributeType? = nil, heroText: String = "") {
        _heroList = heroList
        _favoriteHeroList = favoriteHeroList
        self.filterActivated = filterActivated
        self.heroText = heroText
        _heroesListFiltered = Published(initialValue: heroList.wrappedValue)
    }
    
    func filter(_ text: String) {
        if text == "" {
            if let filterActivated = filterActivated {
                heroesListFiltered = heroList.filter { $0.info.primaryAttr == filterActivated }
            } else {
                heroesListFiltered = heroList
            }
        } else {
            heroesListFiltered = heroList.filter { $0.info.localizedName.lowercased().contains(text.lowercased()) }
        }
    }
    
    func filterBy(atrribute: AttributeType) {
        if atrribute == filterActivated {
            heroesListFiltered = heroList
            filterActivated = nil
            return
        }
        filterActivated = atrribute
        heroesListFiltered = heroList.filter { $0.info.primaryAttr == atrribute }
    }
    
    func addOrRemoveFavoriteHero(_ hero: HeroOrganizationModel) {
        if !favoriteHeroList.contains(where: { $0.info.id == hero.info.id }) {
            withAnimation() {
                favoriteHeroList.append(hero)
            }
            
            heroList.removeAll { $0.info.id == hero.info.id }
        } else {
            heroList.append(hero)
            heroList = heroList.sorted { $0.info.localizedName < $1.info.localizedName }
            
            withAnimation {
                favoriteHeroList.removeAll{ $0.info.id == hero.info.id }
            }
            
        }
    }
}
