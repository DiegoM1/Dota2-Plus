//
//  HomeViewController.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import UIKit
import SwiftUI

struct HomeView: View {
    
    @State var heroesList = [HeroModel]()
    
    var body: some View {
        TabView{
            HeroesTabBarView(viewModel: HeroTabBarViewModel(apiService: HeroTabBarService(dotaService: DotaApiService(urlSession: .shared))))
                .tabItem {
                    Image(systemName: "person")
                    Text("Heroes")
                }
            TeamsTabBarView(viewModel: TeamTabBarViewModel(service:TeamsApiService(service: DotaApiService(urlSession: .shared))))
                .tabItem {
                    Image(systemName: "pencil.slash")
                    Text("Teams")
                }
            
            PlayerView(viewModel: PlayerViewModel(service: PlayerService(service: DotaApiService(urlSession: .shared))))
                .tabItem {
                    Image(systemName: "shareplay")
                    Text("Players")
                }
        }
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(Color.blue, for: .tabBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
