//
//  HeroesGridCellsViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 13/03/23.
//

import SwiftUI

class HeroesGridCellsViewModel: ObservableObject {
    @Binding var heroList: [HeroOrganizationModel]
    @Binding var favoriteHeroList: [HeroOrganizationModel]
    
    init(heroList: Binding<[HeroOrganizationModel]>, favoriteHeroList: Binding<[HeroOrganizationModel]>) {
        _heroList = heroList
        _favoriteHeroList = favoriteHeroList
    }
    
    func addOrRemoveFavoriteHero(_ hero: HeroOrganizationModel) {
        if !favoriteHeroList.contains(where: { $0.info.id == hero.info.id }) {
            
            withAnimation(.easeIn) {
                favoriteHeroList.append(hero)
            }
            heroList.removeAll { $0.info.id == hero.info.id }
        } else {
                heroList.append(hero)
            heroList = heroList.sorted { $0.info.localizedName < $1.info.localizedName }
            favoriteHeroList.removeAll { $0.info.id == hero.info.id }
        }
    }
}
