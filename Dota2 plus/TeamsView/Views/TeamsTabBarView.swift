//
//  TeamsTabBarView.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 8/03/23.
//

import SwiftUI

struct TeamsTabBarView: View {

    @ObservedObject var viewModel: TeamTabBarViewModel
    @State var value: Int = 0
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
                    .task {
                        viewModel.fetchTeamsData()
                    }
            } else {
                VStack(alignment: .leading, spacing: 0) {

                    List {
                        Section("Top 5 teams") {
                            TabView(selection: $value) {
                                ForEach(viewModel.topFiveTeams, id: \.teamId) { team in
                                    HStack(alignment: .center, spacing: 24) {
                                        Text(team.position ?? "")
                                            .font(.largeTitle)
                                            .fontWeight(.bold)
                                            .foregroundColor(.yellow)
                                        VStack(alignment: .center) {
                                            CacheAsyncImage(url: URL(string: team.logoUrl ?? "")!) {
                                                $0.image?
                                                    .resizable()
                                                    .ignoresSafeArea()
                                                    .frame(width: 65, height: 50)
                                            }
                                            Text(team.name)

                                        }
                                        VStack(spacing: 4) {
                                            Text("TAG")
                                                .font(.caption2)
                                            Text("\"\(team.tag)\"")
                                                .font(.title3)

                                        }
                                        VStack {
                                            Text(String(Int(team.rating)))
                                            Text("Rating")
                                                .font(.caption2)
                                        }
                                    }
                                }

                            }
                            .foregroundColor(.white)
                            .listRowBackground(Color(#colorLiteral(red: 0.4801908731, green: 0.05009575933, blue: 0.1161286905, alpha: 1)))
                            .tabViewStyle(.page(indexDisplayMode: .always))
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .frame(height: 180)
                        }

                        Section {
                            ForEach(viewModel.teams, id: \.teamId) { team in
                                HStack(spacing: 0) {
                                    Text(team.position ?? "")
                                        .fontWeight(.black)
                                    AsyncImage(url: URL(string: team.logoUrl ?? "")) {
                                        $0.image?
                                            .resizable()
                                            .frame(width: 60, height: 50)
                                    }
                                    .padding(.trailing, 8)
                                    Text(team.name)
                                        .font(.title2)
                                    Spacer()
                                    HStack(spacing: 16) {
                                        Text(team.tag)
                                            .frame(minWidth: 30)
                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                        Text(String(Int(team.rating)))
                                            .font(.caption)
                                            .fontWeight(.black)
                                    }
                                }
                            }
                        } header: {
                            HStack {
                                Text("Teams")
                            }
                        }
                        .listRowSeparatorTint(.black)
                        .foregroundColor(.black)
                        .listRowBackground(Color("RedSoft"))
                    }
                }
                .navigationTitle("Teams")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}

struct TeamsTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TeamsTabBarView(viewModel: TeamTabBarViewModel(service: TeamsApiService(service: DotaApiService(urlSession: .shared))))
    }
}
