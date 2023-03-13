//
//  HeroesListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 10/03/23.
//

import SwiftUI

struct HeroesListView: View {
    @ObservedObject var viewModel: HeroesListViewModel
    @Binding var moreToogle: Bool
    
    var body: some View {
        List() {
            if !viewModel.favoriteHeroList.isEmpty {
                Section("Favorites") {
                    ForEach(viewModel.favoriteHeroList) { hero in
                        NavigationLink {
                            HeroDetailView(name: hero.name)
                        } label: {
                            VStack(alignment: .leading,spacing: 4) {
                                HStack{
                                    AsyncImage(url: Constants.Urls.heroLogoImage(hero.name)) {
                                        $0.image?
                                            .resizable()
                                            .frame(width: 50, height: 30)
                                    }
                                    
                                    Text(hero.localizedName)
                                        .font(.headline)
                                    Spacer()
                                    Image(systemName: viewModel.favoriteHeroList.contains(where: { $0.id == hero.id}) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .onTapGesture {
                                            viewModel.addOrRemoveFavoriteHero(hero)
                                        }
                                    Image(hero.primaryAttribute.iconName())
                                }
                            }
                        }
                        .listRowBackground(Color("RedSoft"))
                    }
                }
            }
            
            Section {
                ForEach(viewModel.heroList) { hero in
                    NavigationLink {
                        HeroDetailView(name: hero.name)
                    } label: {
                        VStack(alignment: .leading,spacing: 4) {
                            HStack{
                                AsyncImage(url: Constants.Urls.heroLogoImage(hero.name)) {
                                    $0.image?
                                        .resizable()
                                        .frame(width: 50, height: 30)
                                }
                                
                                Text(hero.localizedName)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: viewModel.favoriteHeroList.contains(where: { $0.id == hero.id}) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        viewModel.addOrRemoveFavoriteHero(hero)
                                    }
                                Image(hero.primaryAttribute.iconName())
                            }
                            if moreToogle {
                                Rectangle()
                                    .fill(.black)
                                    .frame(height: 1)
                                HStack {
                                    ForEach(hero.roles, id: \.self) { roles in
                                        Text(roles.rawValue)
                                            .font(.system(size: 12))
                                            .fontDesign(.serif)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground(Color("RedSoft"))
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
