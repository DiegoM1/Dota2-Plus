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
        List {
            if !viewModel.favoriteHeroList.isEmpty {
                Section(header: Text("Favorites")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)) {
                    FavoriteHeroesScrollView(list: $viewModel.favoriteHeroList, action: {hero in
                        viewModel.addOrRemoveFavoriteHero(hero)
                    }, isFavorite: { hero in
                        return  viewModel.favoriteHeroList.contains(where: { hero.info.id == $0.info.id })
                    })
                }
                .listRowBackground(Color("RedSoft"))
            }

            Section(header: Text("Heros")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)) {
                    HeroListComponentView(list: $viewModel.heroList, moreToogle: $moreToogle, action: {hero in
                    viewModel.addOrRemoveFavoriteHero(hero)
                }, isFavorite: { hero in
                    return  viewModel.favoriteHeroList.contains(where: { hero.info.id == $0.info.id })
                })
            }
        }
        .listStyle(.inset)
    }
}

struct HeroListComponentView: View {
    @Binding var list: [HeroOrganizationModel]
    @Binding var moreToogle: Bool
    var action: (HeroOrganizationModel) -> Void
    var isFavorite: (HeroOrganizationModel) -> Bool

    var body: some View {
        ForEach(list, id: \.info.id) { hero in
            NavigationLink {
                HeroDetailView(viewModel: HeroDetailViewModel(apiService: HeroDetailService(dotaService: DotaApiService(urlSession: .shared)), hero: hero))
            } label: {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        CacheAsyncImage(url: Constants.Urls.heroLogoImage(hero.info.name)) {
                            $0.image?
                                .resizable()
                                .frame(width: 50, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .shadow(color: .black, radius: 5)
                        }
                        Text(hero.info.localizedName)
                            .font(.headline)
                        Spacer()

                        Image(systemName: isFavorite(hero) ?  "star.fill" : "star" )
                            .foregroundColor(.yellow)
                            .onTapGesture {
                                action(hero)
                            }
                        Image(hero.info.primaryAttr.iconName())
                            .clipShape(Circle())
                    }

                    if moreToogle {
                        Group {
                            Rectangle()
                                .fill(.black)
                                .frame(height: 1)
                            HStack {
                                ForEach(hero.info.roles, id: \.self) { roles in
                                    Text(roles.rawValue)
                                        .font(.system(size: 12))
                                        .fontDesign(.serif)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .listRowBackground(Color("RedSoft"))
        }
    }
}
