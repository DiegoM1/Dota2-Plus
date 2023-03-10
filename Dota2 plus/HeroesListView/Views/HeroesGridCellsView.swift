//
//  HeroesGridCellsView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 10/03/23.
//

import SwiftUI

struct HeroesGridCellsView: View {
    var heroesList: [HeroModel]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())], spacing: 4) {
                ForEach(heroesList, id: \.id) { hero in
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
}

struct HeroesGridCellsView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesGridCellsView(heroesList: [])
    }
}
