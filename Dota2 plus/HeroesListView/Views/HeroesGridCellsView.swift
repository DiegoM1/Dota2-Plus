//
//  HeroesGridCellsView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 10/03/23.
//

import SwiftUI

struct HeroesGridCellsView: View {
    @ObservedObject var viewModel: HeroesGridCellsViewModel
    var body: some View {
        ScrollView {
            if !viewModel.favoriteHeroList.isEmpty {
                HStack {
                    Text("Favorites")
                        .font(.system(size: 16, weight: .bold))
                    Spacer()
                }
                .padding(.horizontal, 6)
                LazyVGrid(columns: [GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible()),
                                    GridItem(.flexible())], spacing: 4) {
                    ForEach(viewModel.favoriteHeroList, id: \.id) { hero in
                        NavigationLink {
                            HeroDetailView(viewModel: HeroDetailViewModel(hero: hero))
                        } label: {
                            VStack(alignment: .center) {
                                HStack {
                                    Spacer()
                                    Image(systemName: viewModel.favoriteHeroList.contains{ $0.id == hero.id} ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .onTapGesture {
                                            viewModel.addOrRemoveFavoriteHero(hero)
                                        }
                                }
                                AsyncImage(url: Constants.Urls.heroIconImage(hero.icon)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    
                                        .frame(width: 50, height: 50)
                                    
                                    Spacer()
                                    Text(hero.localizedName)
                                        .foregroundColor(Color("Burgundy"))
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                        .fontDesign(.serif)
                                } placeholder: {
                                    Image(systemName: "photo.fill")
                                }
                                .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.height / 12)
                                
                                Spacer()
                            }
                        }
                    }
                }
                                    .padding(.horizontal, 6)
                Rectangle()
                    .fill(Color("Burgundy"))
                    .frame(height: 1)
                    .padding()
            }
            
            LazyVGrid(columns: [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())], spacing: 4) {
                ForEach(viewModel.heroList, id: \.id) { hero in
                    NavigationLink {
                        HeroDetailView(viewModel: HeroDetailViewModel(hero: hero))
                    } label: {
                        VStack(alignment: .center) {
                            HStack {
                                Spacer()
                                Image(systemName: viewModel.favoriteHeroList.contains{ $0.id == hero.id} ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        viewModel.addOrRemoveFavoriteHero(hero)
                                    }
                            }
                            AsyncImage(url: Constants.Urls.heroIconImage(hero.icon)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                Image(systemName: "photo.fill")
                            }
                            .frame(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.height / 12)
                            
                            Spacer()
                            
                            Text(hero.localizedName)
                                .foregroundColor(Color("Burgundy"))
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .fontDesign(.serif)
                        }
                    }
                }
            }
                                .padding(.horizontal, 6)
            
        } .background(Color("RedSoft"))
    }
}
