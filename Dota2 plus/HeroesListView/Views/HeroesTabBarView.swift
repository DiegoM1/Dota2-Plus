//
//  HeroesListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct HeroesTabBarView: View {
    @StateObject var viewModel: HeroesListViewModel
    @State var moreToogle = false
    @State var alterView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if alterView {
                    HeroesGridCellsView(heroesList: viewModel.heroesListFiltered)
                } else {
                    HeroesListView(heroList: viewModel.heroesListFiltered, moreToogle: $moreToogle)
                }
            }
            .onAppear{
                viewModel.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SearchableHeroListView(viewModel: viewModel)
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
            .onChange(of: viewModel.heroText, perform: { newValue in
                viewModel.filter(newValue)
            })
            .navigationTitle("Heroes")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct HeroesListVIewController_Previews: PreviewProvider {
    static var previews: some View {
        HeroesTabBarView(viewModel: HeroesListViewModel(apiService: DotaApiService()), moreToogle: true, alterView: true)
    }
}
