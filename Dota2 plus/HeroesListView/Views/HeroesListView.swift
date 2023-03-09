//
//  HeroesListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct HeroesListView: View {
    @ObservedObject var viewModel: HeroesListViewModel
    @State var moreToogle = false
    @State var alterView = false
    
    var body: some View {
        NavigationView {
            VStack {
                if alterView {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()),
                                            GridItem(.flexible()),
                                            GridItem(.flexible()),
                                            GridItem(.flexible())], spacing: 4) {
                            ForEach(Array(viewModel.heroesListFiltered.enumerated()), id: \.offset) { index, hero in
                                NavigationLink {
                                    HeroDetailView(name: hero.localizedName)
                                } label: {
                                    VStack(alignment: .center) {
                                        AsyncImage(url: Constants.Urls.heroLogoImage(hero.name)) { image in
                                            image
                                                .resizable()
                                        } placeholder: {
                                            Image(systemName: "photo.fill")
                                        }
                                        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.height / 10)
                                        
                                        Spacer()
                                        
                                        Text(hero.localizedName)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .fontWeight(.semibold)
                                            .fontDesign(.serif)
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    List(viewModel.heroesListFiltered) { hero in
                        NavigationLink {
                            HeroDetailView(name: hero.localizedName)
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
                    .listStyle(.insetGrouped)
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
            .onAppear{
                viewModel.fetchData()
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
        HeroesListView(viewModel: HeroesListViewModel(apiService: DotaApiService()), moreToogle: true, alterView: true)
    }
}
