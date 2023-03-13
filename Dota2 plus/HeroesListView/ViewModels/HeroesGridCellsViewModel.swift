//
//  HeroesGridCellsViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 13/03/23.
//

import SwiftUI

class HeroesGridCellsViewModel: ObservableObject {
    @Binding var heroList: [HeroModel]
    @Binding var favoriteHeroList: [HeroModel]
    
    init(heroList: Binding<[HeroModel]>, favoriteHeroList: Binding<[HeroModel]>) {
        _heroList = heroList
        _favoriteHeroList = favoriteHeroList
    }
    
    func addOrRemoveFavoriteHero(_ hero: HeroModel) {
        if !favoriteHeroList.contains(where: { $0.id == hero.id }) {
            
            withAnimation(.easeIn) {
                favoriteHeroList.append(hero)
            }
                heroList.removeAll { $0.id == hero.id}
        } else {
                heroList.append(hero)
                heroList = heroList.sorted { $0.localizedName < $1.localizedName}
                favoriteHeroList.removeAll{ $0.id == hero.id}
        }
    }
}
