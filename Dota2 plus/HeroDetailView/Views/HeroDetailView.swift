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
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                AsyncImage(url: Constants.Urls.heroLogoImage(hero.name)) {
                    $0.image?
                        .resizable()
                        .cornerRadius(12)
                        .frame(width: 150, height: 150)
                        .padding(.leading, 6)
                        .padding(.trailing, 10)
                }
                VStack {
                    HStack {
                        Text(hero.localizedName)
                            .fontWeight(.semibold)
                            .fontDesign(.serif)
                        AsyncImage(url: Constants.Urls.heroIconImage(hero.icon))
                            .frame(width: 24, height: 24)
                    }
                    Rectangle()
                        .fill(.black)
                        .frame(height: 1)
                    
                    HStack(spacing: 0) {
                        VStack{
                            AttributeScaleView(attribute: .str, base: viewModel.str, gain: viewModel.level != 1 ? nil : hero.strGain)
                            AttributeScaleView(attribute: .agi, base: viewModel.agi, gain: viewModel.level != 1 ? nil : hero.agiGain)
                            AttributeScaleView(attribute: .int, base: viewModel.int, gain: viewModel.level != 1 ? nil : hero.intGain)
                        }
                        
                        VStack {
                            HStack {
                                Image(hero.attackType == .meele ? "sword" : "archery")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("\(hero.baseAttackMin) - \(hero.baseAttackMax)")
                                    .fontWeight(.semibold)
                                
                                Spacer()
                            }
                            HStack {
                                Image("running")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("\(hero.moveSpeed)")
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
                Rectangle()
                    .frame(height: 25)
                    .foregroundColor(.green)
                    .overlay {
                        VStack {
                            Text(viewModel.realHealth)
                                .fontWeight(.semibold)
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
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .fontDesign(.serif)
                        }
                    }
            }
            .cornerRadius(3)
            .padding(.horizontal, 6)
            .padding(.vertical, 16)
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
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(hero.localizedName)")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("Gray"))
        .foregroundColor(.white)
    }
}

struct HeroDetailsViewControlle_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(viewModel: HeroDetailViewModel(hero: HeroModel(id: 1, name: "npc_dota_hero_antimage",
                                                                      localizedName: "Anti-Mage",
                                                                      primaryAttr: .agi,
                                                                      attackType: .meele,
                                                                      roles: [.carry,.escape,.nuker],
                                                                      img: "/apps/dota2/images/dota_react/heroes/antimage.png?",
                                                                      icon: "/apps/dota2/images/dota_react/heroes/icons/antimage.png?",
                                                                      baseHealth: 200,
                                                                      baseHealthRegen:
                                                                        0.25,
                                                                      baseMana: 75,
                                                                      baseManaRegen: 0,
                                                                      baseArmor: 0,
                                                                      baseAttackMin: 29,
                                                                      baseAttackMax: 33,
                                                                      baseStr: 21,
                                                                      baseAgi: 24,
                                                                      baseInt: 12,
                                                                      strGain: 1.6,
                                                                      agiGain: 2.8,
                                                                      intGain: 1.8,
                                                                      attackRange: 150,
                                                                      projectileSpeed: 0,
                                                                      attackRate: 1.4,
                                                                      baseAttackTime: 100,
                                                                      attackPoint: 0.3,
                                                                      moveSpeed: 310, cmEnabled: true, legs: 2, dayVision: 1800, nightVision: 800, turboPicks: 371300, turboWins: 202315, proBan: 194, proWin: 37, proPick: 80)))
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



