//
//  HeroesListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct HeroesListView: View {
    @ObservedObject var viewModel: HeroesListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.heroesListFiltered) { hero in
                    NavigationLink {
                        HeroDetailView(name: hero.localizedName)
                    } label: {
                        HStack{
                            Text(hero.localizedName)
                                .font(.headline)
                            Spacer()
                            Image(hero.primaryAttribute.iconName())
                        }
                    }
                }
                .listStyle(.plain)
                .onAppear{
                    viewModel.fetchData()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        SearchableHeroListView(viewModel: viewModel)
                    }label: {
                        Image(systemName: "magnifyingglass")
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
        HeroesListView(viewModel: HeroesListViewModel(apiService: DotaApiService()))
    }
}
