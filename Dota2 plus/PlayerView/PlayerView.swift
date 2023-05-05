//
//  ItemsView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 14/03/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct PlayerView: View {
    @ObservedObject var viewModel: PlayerViewModel
    @State var idText = ""
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
                    .task {
                        viewModel.fetchPlayerData()
                    }
            } else {
                if viewModel.player == nil || viewModel.playerId == nil {
                    List {
                        Section("Player id") {
                            HStack {
                                TextField("Add id", text: $idText)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                Button {
                                    viewModel.isLoading = true
                                    viewModel.playerId = Int(idText)
                                    viewModel.fetchPlayerData()
                                } label: {
                                    Text("Save")
                                }
                                .disabled(idText == "" ? true : false)
                                .buttonStyle(.borderedProminent)
                            }
                        }
                        Text("Remember to add your id or your friend's id to fetch his data.")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Burgundy"))
                        
                    }
                    .task {
                        if viewModel.playerId != nil {
                            viewModel.fetchPlayerData()
                        }
                    }
                    .navigationTitle("Player")
                    .navigationBarTitleDisplayMode(.large)
                } else {
                    VStack {
                        if let profile = viewModel.player?.profile {
                            HStack {
                                AsyncImage(url: URL(string: profile.avatarfull)!) {
                                    $0.image?
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .shadow(radius: 32)
                                }
                            }
                            
                            Text(profile.personaname)
                                .font(.title2)
                                .fontDesign(.serif)
                            Spacer()
                            List {
                                Section("Steam id") {
                                    Text(profile.steamid)
                                        .fontDesign(.rounded)
                                        .onTapGesture(count: 2) {
                                            UIPasteboard.general.string = profile.steamid
                                        }
                                }
                                Section("Profile url") {
                                    Link("Steam profile", destination: URL(string: profile.profileurl)!)
                                    
                                }
                                
                                Section("Dota plus") {
                                    Text(profile.plus ? "You have dota plus supcrition" : "You don't have dota plus supcrition")
                                }
                                if viewModel.player.leaderboardRank != nil {
                                    Section("Leaderboard rank") {
                                        Text("TOP \(viewModel.player.leaderboardRank ?? 0)")
                                    }
                                }
                                
                                if viewModel.player.mmrEstimate != nil {
                                    Section("Mmr estimate") {
                                        Text("MMR -> \(viewModel.player.mmrEstimate?["estimate"] ?? 0)")
                                    }
                                }
                            }
                            Spacer()
                        } else {
                            Spacer()
                            Text("User is not found. Remember to create an account in OpenDotan and connect your steam account.")
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("Burgundy"))
                            Spacer()
                        }
                    }
                    .toolbar {
                        ToolbarItem {
                            Button {
                                viewModel.playerId = nil
                                viewModel.player = nil
                            } label: {
                                Image(systemName: "repeat")
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(viewModel: PlayerViewModel(service: PlayerService(service: DotaApiService(urlSession: .shared))))
    }
}
