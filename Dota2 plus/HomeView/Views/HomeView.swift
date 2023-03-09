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
            HeroesListView(viewModel: HeroesListViewModel(apiService: DotaApiService()))
                .tabItem {
                    Image(systemName: "person")
                    Text("Heroes")
                }
            TeamsTabBarView(viewModel: TeamTabBarViewModel(service: DotaApiService()))
                .tabItem {
                    Image(systemName: "pencil.slash")
                    Text("Teams")
            }
            
            Text("Players")
                .tabItem {
                    Image(systemName: "shareplay")
                    Text("Players")
                }
        }
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
