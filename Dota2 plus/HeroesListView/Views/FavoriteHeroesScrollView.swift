//
//  FavoriteHeroesScrollView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/11/23.
//

import SwiftUI

struct FavoriteHeroesScrollView: View {
    @Binding var list: [HeroOrganizationModel]
    var action: (HeroOrganizationModel) -> Void
    var isFavorite: (HeroOrganizationModel) -> Bool

    var body: some View {
        ScrollViewReader { _ in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(list, id: \.info.id ) { hero in
                        NavigationLink {
                            HeroDetailView(viewModel: HeroDetailViewModel(apiService: HeroDetailService(dotaService: DotaApiService(urlSession: .shared)), hero: hero))
                        } label: {
                            VStack(spacing: 0) {
                                HStack(alignment: .top) {
                                    Spacer()
                                    Image(systemName: isFavorite(hero) ?  "star.fill" : "star" )
                                        .foregroundColor(.yellow)
                                        .onTapGesture {
                                            action(hero)
                                        }
                                        .padding(.horizontal)
                                }
                                CacheAsyncImage(url: Constants.Urls.heroIconImage(hero.info.icon)) {
                                    $0.image?
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                                HStack(spacing: 0) {
                                    Text(hero.info.localizedName)
                                        .font(.title3)
                                        .bold()
                                        .padding(.horizontal, 10)
                                    Image(hero.info.primaryAttr.iconName())
                                        .clipShape(Circle())
                                }
                            }
                        }
                        .foregroundColor(.white)
                        .id(hero.info.id)
                        .frame(width: 280, height: 150)
                        .background(
                            CacheAsyncImage(url: Constants.Urls.heroLogoImage(hero.info.name)) {
                                $0.image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                                    .overlay(content: {
                                        RoundedRectangle(cornerRadius: 30)
                                                            .fill(Color.black.opacity(0.7))
                                    })
                                    .shadow(radius: 8)
                            }
                        )
                    }
                }
                .padding(.leading, 5)
                .padding(.trailing, 20)
            }
            .frame(height: 150)
            .scrollClipDisabled()
        }
    }
}

struct FavoriteHeroesScrollView_Previews: PreviewProvider {
    static var previews: some View {
        @State var list: [HeroOrganizationModel] = [HeroOrganizationModel(info: HeroData(id: 1,
                                                                                         name: "npc_dota_hero_antimage",
                                                                                         localizedName: "Anti-mage",
                                                                                         primaryAttr: .agi,
                                                                                         attackType: .meele,
                                                                                         roles: [.carry, .escape, .nuker],
                                                                                         img: "/apps/dota2/images/dota_react/heroes/antimage.png?",
                                                                                         icon: "/apps/dota2/images/dota_react/heroes/icons/antimage.png?"),
                                                                          healthStr: BaseHeroStatsStr(baseHealth: 200, baseHealthRegen: 0.25, baseStr: 21, strGain: 1.6),
                                                                          manaInt: BaseHeroStatsInt(baseMana: 75, baseManaRegen: 0, baseInt: 12, intGain: 1.8),
                                                                          armorAgi: BaseHeroStatsAgi(baseArmor: 0, agiGain: 2.0, baseAgi: 24),
                                                                          attack: AttackHero(baseAttackMin: 29, baseAttackMax: 33, attackRange: 150, projectileSpeed: 0, attackRate: 1.4, baseAttackTime: 100, attackPoint: 0.3),
                                                                          movement: MovementHero(speed: 310, legs: 2),
                                                                          draft: PicksWinRateHero(cmEnabled: true, turboPicks: 371300, turboWins: 202315, proBan: 194, proWin: 37, proPick: 80), vision: VisionHero(dayVision: 1800, nightVision: 800)),
                                                    HeroOrganizationModel(info: HeroData(id: 1,
                                                                                         name: "npc_dota_hero_antimage",
                                                                                         localizedName: "Anti-mage",
                                                                                         primaryAttr: .agi,
                                                                                         attackType: .meele,
                                                                                         roles: [.carry, .escape, .nuker],
                                                                                         img: "/apps/dota2/images/dota_react/heroes/antimage.png?",
                                                                                         icon: "/apps/dota2/images/dota_react/heroes/icons/antimage.png?"),
                                                                          healthStr: BaseHeroStatsStr(baseHealth: 200, baseHealthRegen: 0.25, baseStr: 21, strGain: 1.6),
                                                                          manaInt: BaseHeroStatsInt(baseMana: 75, baseManaRegen: 0, baseInt: 12, intGain: 1.8),
                                                                          armorAgi: BaseHeroStatsAgi(baseArmor: 0, agiGain: 2.0, baseAgi: 24),
                                                                          attack: AttackHero(baseAttackMin: 29, baseAttackMax: 33, attackRange: 150, projectileSpeed: 0, attackRate: 1.4, baseAttackTime: 100, attackPoint: 0.3),
                                                                          movement: MovementHero(speed: 310, legs: 2),
                                                                          draft: PicksWinRateHero(cmEnabled: true, turboPicks: 371300, turboWins: 202315, proBan: 194, proWin: 37, proPick: 80), vision: VisionHero(dayVision: 1800, nightVision: 800))]
        return FavoriteHeroesScrollView(list: $list, action: { hero in
            print(hero.info.localizedName)

        }, isFavorite: { _ in
            return true
        })
    }
}
