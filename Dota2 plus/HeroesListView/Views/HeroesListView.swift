//
//  HeroesListView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 10/03/23.
//

import SwiftUI

struct HeroesListView: View {
    var heroList: [HeroModel]
    @Binding var moreToogle: Bool
    
    var body: some View {
        List(heroList) { hero in
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

struct heroesListView_Previews: PreviewProvider {
    static var previews: some View {
        HeroesListView(heroList: [], moreToogle: .constant(true))
    }
}
