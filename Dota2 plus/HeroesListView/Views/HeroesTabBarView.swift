//
//  HeroesListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct HeroesTabBarView: View {
    @ObservedObject var viewModel: HeroTabBarViewModel
    @State var moreToogle = false
    @State var alterView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if alterView {
                    HeroesGridCellsView(viewModel: HeroesGridCellsViewModel(heroList: $viewModel.heroesListFiltered, favoriteHeroList: $viewModel.favoriteHeroes))
                } else {
                    HeroesListView(viewModel: HeroesListViewModel(heroList: $viewModel.heroesListFiltered, favoriteHeroList: $viewModel.favoriteHeroes), moreToogle: $moreToogle)
                }
            }
            .onAppear{
                viewModel.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SearchableHeroListView(viewModel: HeroesListViewModel(heroList: $viewModel.heroesListFiltered, favoriteHeroList: $viewModel.favoriteHeroes))
                    }label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {
                            alterView.toggle()
                        }label: {
                            if !alterView {
                                Image(systemName: "square.grid.3x3.bottommiddle.fill")
                            } else {
                                Image(systemName: "list.bullet.clipboard")
                            }
                        }
                        Button {
                            alterView = false
                            moreToogle.toggle()
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }

            }
           
            .navigationTitle("Heroes")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct HeroesListVIewController_Previews: PreviewProvider {
    static var previews: some View {
        HeroesTabBarView(viewModel: HeroTabBarViewModel(apiService: DotaApiService()), moreToogle: true, alterView: true)
    }
}
