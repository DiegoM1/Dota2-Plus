//
//  HeroDetailView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import SwiftUI

struct HeroDetailView: View {
    @ObservedObject var viewModel: HeroDetailViewModel
    var body: some View {
        let hero = viewModel.hero
        ScrollView {
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    AsyncImage(url: Constants.Urls.heroLogoImage(hero.info.name)) {
                        $0.image?
                            .resizable()
                            .cornerRadius(12)
                            .frame(width: 130)
                            .padding()
                    }
                    VStack {
                        HStack {
                            Text(hero.info.localizedName)
                                .fontWeight(.semibold)
                                .fontDesign(.serif)
                            AsyncImage(url: Constants.Urls.heroIconImage(hero.info.icon))
                                .frame(width: 24, height: 24)
                            Button {
                                Task {
                                    await viewModel.addOrRemoveFavoriteHero()
                                }
                            } label: {
                                if viewModel.isFavoriteHero {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                } else {
                                    Image(systemName: "star")
                                }
                            }

                        }
                        Rectangle()
                            .fill(.black)
                            .frame(height: 1)
                        HStack(spacing: 0) {
                            VStack {
                                AttributeScaleView(attribute: .str,
                                                   base: viewModel.str,
                                                   gain: viewModel.level != 1 ? nil : hero.healthStr.strGain)
                                AttributeScaleView(attribute: .agi,
                                                   base: viewModel.agi,
                                                   gain: viewModel.level != 1 ? nil : hero.armorAgi.agiGain)
                                AttributeScaleView(attribute: .int,
                                                   base: viewModel.int,
                                                   gain: viewModel.level != 1 ? nil : hero.manaInt.intGain)
                            }
                            VStack {
                                HStack {
                                    Image(hero.info.attackType == .meele ? "sword" : "archery")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text("\(hero.attack.baseAttackMin) - \(hero.attack.baseAttackMax)")
                                        .fontWeight(.semibold)

                                    Spacer()
                                }
                                HStack {
                                    Image("running")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text("\(hero.movement.speed)")
                                        .fontWeight(.semibold)

                                    Spacer()
                                }
                                HStack {
                                    Image("shield")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text(viewModel.realArmor)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                VStack(spacing: 0) {
                    HStack(alignment: .center) {
                        ForEach(viewModel.hero.info.roles, id: \.self) { role in
                            Spacer()
                            Text(role.rawValue)
                                .font(.system(size: 14))
                                .bold()
                            Spacer()
                        }
                    }
                    .padding(.bottom, 8)
                    Rectangle()
                        .frame(height: 25)
                        .foregroundColor(.green)
                        .overlay {
                            VStack {
                                Text(viewModel.realHealth)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .fontDesign(.serif)
                            }
                        }
                    Rectangle()
                        .frame(height: 25)
                        .foregroundColor(.blue)
                        .overlay {
                            VStack {
                                Text("\(viewModel.realMana)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .fontDesign(.serif)
                            }
                        }
                }
                .cornerRadius(3)
                .padding(.horizontal, 6)
                .padding(.vertical, 8)
                VStack {
                    HStack {
                        Text("Calculate level stats = \(Int(viewModel.level))" )
                        Spacer()
                    }
                    HStack {
                        Button {
                            viewModel.level -= 1
                        } label: {
                            Image(systemName: "minus.square")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .opacity(viewModel.level == 1 ? 0.5 : 1)
                        .disabled(viewModel.level == 1 ? true : false)
                        Slider(value: $viewModel.level, in: 1...30)
                            .tint(.red)
                            .allowsHitTesting(false)
                        Button {
                            viewModel.level += 1
                        } label: {
                            Image(systemName: "plus.app")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .opacity(viewModel.level == 30 ? 0.5 : 1)
                        .disabled(viewModel.level == 30 ? true : false)
                    }
                }
                .padding(.horizontal)
                HStack(spacing: 32) {
                    Text("Hero Lore")
                        .bold()
                    Button {
                        viewModel.showLore.toggle()
                    } label: {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color("Burgundy"))
                    Spacer()
                }
                .padding(.horizontal)
                if viewModel.showLore {
                    Text(viewModel.loreHolder)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke())
                        .padding(.horizontal)
                }
                HStack {
                    Text("Hero vision: ")
                    Spacer()
                    Image(systemName: "sun.max.fill")
                    Text(String(hero.vision.dayVision))
                        .bold()
                    Text("/")
                    Image(systemName: "moon.fill")
                    Text(String(hero.vision.nightVision))
                        .bold()
                }
                .padding()
                WinRateView(cmEnabled: hero.draft.cmEnabled,
                            proWinratePercentage: viewModel.proWinratePercentage,
                            turboWinratePercentage: viewModel.turboWinratePercentage)
                HStack {
                    Text("For more information go to")
                        .font(.system(size: 12))
                    Link("\(hero.info.localizedName)",
                         destination: Constants.Urls.urlHeroLink(hero.info.localizedName))
                    .bold()
                    .foregroundColor(.blue)
                }.padding(.vertical, 40)
            }
            .task {
                viewModel.fetchHeroData()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(hero.info.localizedName)")
                }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .navigationBarTitleDisplayMode(.inline)
        }
        .foregroundColor(.white)
        .background(Color("Gray"))
    }
}

struct HeroDetailsViewControlle_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(viewModel: HeroDetailViewModel(apiService: HeroDetailService(dotaService: DotaApiService(urlSession: .shared)),
                                                      hero: HeroOrganizationModel(info: HeroData(id: 1,
                                                                                                 name: "npc_dota_hero_antimage",
                                                                                                 localizedName: "Anti-mage", primaryAttr: .agi,
                                                                                                 attackType: .meele,
                                                                                                 roles: [.carry, .escape, .nuker],
                                                                                                 img: "/apps/dota2/images/dota_react/heroes/antimage.png?",
                                                                                                 icon: "/apps/dota2/images/dota_react/heroes/icons/antimage.png?"),
                                                                                  healthStr: BaseHeroStatsStr(baseHealth: 200, baseHealthRegen: 0.25, baseStr: 21, strGain: 1.6),
                                                                                  manaInt: BaseHeroStatsInt(baseMana: 75,
                                                                                                            baseManaRegen: 0,
                                                                                                            baseInt: 12,
                                                                                                            intGain: 1.8),
                                                                                  armorAgi: BaseHeroStatsAgi(baseArmor: 0,
                                                                                                             agiGain: 2.0,
                                                                                                             baseAgi: 24),
                                                                                  attack: AttackHero(baseAttackMin: 29,
                                                                                                     baseAttackMax: 33,
                                                                                                     attackRange: 150,
                                                                                                     projectileSpeed: 0,
                                                                                                     attackRate: 1.4,
                                                                                                     baseAttackTime: 100,
                                                                                                     attackPoint: 0.3),
                                                                                  movement: MovementHero(speed: 310, legs: 2),
                                                                                  draft: PicksWinRateHero(cmEnabled: true,
                                                                                                          turboPicks: 371300,
                                                                                                          turboWins: 202315,
                                                                                                          proBan: 194,
                                                                                                          proWin: 37,
                                                                                                          proPick: 80),
                                                                                  vision: VisionHero(dayVision: 1800,
                                                                                                    nightVision: 800))))
    }
}

struct AttributeScaleView: View {
    var attribute: AttributeType
    var base: String
    var gain: Double?
    var body: some View {
        HStack(spacing: 2) {
            Image(attribute.iconName())
                .resizable()
                .frame(width: 24, height: 24)
            Text(base)
                .fontWeight(.semibold)
            if gain != nil {
                Text("+ \(String(format: "%.2f", gain!))")
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            Spacer()
        }
    }
}

struct WinRateView: View {
    var cmEnabled: Bool
    var proWinratePercentage: String
    var turboWinratePercentage: String
    var body: some View {
        VStack(spacing: 16) {
            Text("Captain's Mode & Winrate Information:")
                .bold()
            HStack {
                Text("Captains Mode enabled:")
                Spacer()
                Text(cmEnabled ? "YES" : "NO")
                    .bold()
            }
            HStack {
                Text("Pro games winrate:")
                Spacer()
                Text("\(proWinratePercentage) %")
                    .bold()
            }
            HStack {
                Text("Turbo games winrate:")
                Spacer()
                Text("\(turboWinratePercentage) %")
                    .bold()
            }
        }
        .padding(.horizontal)
    }
}
