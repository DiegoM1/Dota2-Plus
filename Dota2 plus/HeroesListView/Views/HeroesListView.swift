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
                            AsyncImage(url: Constants.Urls.heroLogoImage(hero.name)) {
                                $0.image?
                                    .resizable()
                                    .frame(width: 50, height: 30)
                            }
                            
                            Text(hero.localizedName)
                                .font(.headline)
                            Spacer()
                            Image(hero.primaryAttribute.iconName())
                        }
                    }
                    .listRowBackground(Color("RedSoft"))
                }
                .listStyle(.insetGrouped)
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
            .background(Color(#colorLiteral(red: 0.9733771682, green: 0.8993731141, blue: 0.9351933599, alpha: 1)))
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
