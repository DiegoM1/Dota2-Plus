//
//  HomeViewController.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 7/03/23.
//

import UIKit
import SwiftUI

struct HomeViewController: View {
    
    @State var heroesList = [HeroModel]()
    
    var body: some View {
        TabView{
            HeroesListViewController(viewModel: HeroesListViewModel())
                .tabItem {
                    Image(systemName: "person")
                    Text("Heroes")
                }
            Text("Items")
                .tabItem {
                    Image(systemName: "pencil.slash")
                    Text("Items")
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
        HomeViewController()
    }
}
