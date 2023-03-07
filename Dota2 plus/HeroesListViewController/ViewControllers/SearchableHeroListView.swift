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
                            .frame(width: 12,height: 12)
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
                            .frame(width: 12,height: 12)
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
                            .frame(width: 12,height: 12)
                            .background(Circle().fill(viewModel.filterActivated == attribute ? attribute.foregroundColor() : .clear))
                        
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .searchable(text: $viewModel.heroText, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct SearchableHeroListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableHeroListView(viewModel: HeroesListViewModel(apiService: DotaApiService()))
    }
}
