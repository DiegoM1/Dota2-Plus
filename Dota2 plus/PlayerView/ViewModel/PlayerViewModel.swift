//
//  ItemsViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 14/03/23.
//

import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var isLoading = true
    var playerId: Int? = UserDefaults.standard.value(forKey: "userId") as? Int {
        didSet {
            UserDefaults.standard.set(playerId, forKey: "userId")
        }
    }
    @Published var player: PlayerModel!
    var service: PlayerService

    init(service: PlayerService) {
        self.service = service
    }

    func fetchPlayerData() {
        service.fetchData(playerId ?? 0) { data in
            self.player = data
            self.isLoading.toggle()
        }
    }

}
