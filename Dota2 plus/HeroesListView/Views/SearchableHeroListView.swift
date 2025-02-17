//
//  SearchableHeroListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct SearchableHeroListView: View {
    @ObservedObject var viewModel: HeroesListViewModel
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.heroesListFiltered, id: \.info.id) { hero in
                    NavigationLink {
                        HeroDetailView(viewModel: HeroDetailViewModel(apiService: HeroDetailService(dotaService: DotaApiService(urlSession: .shared)), hero: hero))
                    } label: {
                        VStack {
                            HStack {
                                AsyncImage(url: Constants.Urls.heroLogoImage(hero.info.name)) {
                                    $0.image?
                                        .resizable()
                                        .frame(width: 35, height: 20)
                                }
                                Text(hero.info.localizedName)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(hero.info.primaryAttr.iconName())
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray.opacity(0.8))
                            }
                            Divider()
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Filter") {
                    Button {
                        viewModel.filterBy(atrribute: AttributeType.agi)
                    } label: {
                        let attribute = AttributeType.agi
                        Text("Agility")
                            .foregroundColor(attribute.foregroundColor())
                        Circle()
                            .strokeBorder(attribute.foregroundColor(), lineWidth: 1)
                            .frame(width: 12, height: 12)
                            .background(Circle().fill(viewModel.filterActivated == attribute ? attribute.foregroundColor() : .clear))
                    }
                    Button {
                        viewModel.filterBy(atrribute: AttributeType.str)
                    } label: {
                        let attribute = AttributeType.str
                        Text("Strenght")
                            .foregroundColor(attribute.foregroundColor())
                        Circle()
                            .strokeBorder(attribute.foregroundColor(), lineWidth: 1)
                            .frame(width: 12, height: 12)
                            .background(Circle().fill(viewModel.filterActivated == attribute ? attribute.foregroundColor() : .clear))
                    }
                    Button {
                        viewModel.filterBy(atrribute: AttributeType.int)
                    } label: {
                        let attribute = AttributeType.int
                        Text("Intelligence")
                            .foregroundColor(attribute.foregroundColor())
                        Circle()
                            .strokeBorder(attribute.foregroundColor(), lineWidth: 1)
                            .frame(width: 12, height: 12)
                            .background(Circle().fill(viewModel.filterActivated == attribute ? attribute.foregroundColor() : .clear))

                    }
                    Button {
                        viewModel.filterBy(atrribute: AttributeType.all)
                    } label: {
                        let attribute = AttributeType.all
                        Text("Universal")
                            .foregroundColor(attribute.foregroundColor())
                        Circle()
                            .strokeBorder(attribute.foregroundColor(), lineWidth: 1)
                            .frame(width: 12, height: 12)
                            .background(Circle().fill(viewModel.filterActivated == attribute ? attribute.foregroundColor() : .clear))

                    }
                }
            }
        }
        .onChange(of: viewModel.heroText) { _, newValue in
            viewModel.filter(newValue)
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .searchable(text: $viewModel.heroText, placement: .navigationBarDrawer(displayMode: .always))
    }
}
