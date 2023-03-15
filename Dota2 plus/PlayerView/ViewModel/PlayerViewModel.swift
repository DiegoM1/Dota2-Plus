//
//  ItemsViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 14/03/23.
//

import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var isLoading = true
    var playerId: Int? = UserDefaults.standard.value(forKey: "userId") as? Int  {
        didSet {
            UserDefaults.standard.set(playerId, forKey: "userId")
        }
    }
    @Published var player: PlayerModel!
    
    func fetchData(_ id: Int) {
        UserDefaults.standard.set(id, forKey: "userId")
        let resource = Resource(url: Constants.Urls.urlPlayer(id)) { data in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(PlayerModel.self, from: data)
                return data
            } catch {
                print(error)
            }
            
            return nil
        }
        
        
        Task {
           await DotaApiService().fetchData(request: resource) { data in
                if let data = data {
                    self.player = data
                    self.isLoading = false
                }
            }
        }
    }
    
}
