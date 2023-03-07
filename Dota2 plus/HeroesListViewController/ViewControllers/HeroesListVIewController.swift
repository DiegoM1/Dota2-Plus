//
//  HeroesListViewController.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct HeroesListViewController: View {
    @ObservedObject var viewModel: HeroesListViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
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
                    Spacer()
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
                    Spacer()
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
                .padding(.horizontal, 32)
                
                List(viewModel.heroesListFiltered) { hero in
                    NavigationLink {
                        HeroDetailViewController(name: hero.localizedName)
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
            .searchable(text: $viewModel.heroText)
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
        HeroesListViewController(viewModel: HeroesListViewModel())
    }
}
