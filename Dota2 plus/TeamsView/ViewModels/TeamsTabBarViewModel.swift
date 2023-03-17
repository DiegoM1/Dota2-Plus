//
//  TeamsTabBarViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 8/03/23.
//

import SwiftUI

@MainActor
class TeamTabBarViewModel: ObservableObject {
    
    @Published var topFiveTeams = [TeamModel]()
    @Published var teams = [TeamModel]()
    @Published var isLoading = true
    
    var fetchedTeams = [TeamModel]() {
        didSet {
            dataConstruction()
        }
    }
    var service: TeamsApiService
    
    init(service: TeamsApiService) {
        self.service = service
    }
    
    func fetchTeamsData() {
        service.fetchTeamData { data in
            var teams = data
            self.orderConstruction(&teams)
            self.fetchedTeams = teams
            self.isLoading = false
        }
    }
    
    func dataConstruction() {
        topFiveTeams = Array(fetchedTeams.prefix(through: 4))
        teams = Array(fetchedTeams.suffix(95))
        
        
    }
    func orderConstruction(_ array: inout [TeamModel]) {
        for index in 1..<array.count {
            array[index - 1].position = index.ordinal
        }
    }
}

private var ordinalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter
}()

extension Int {
    var ordinal: String? {
        return ordinalFormatter.string(from: NSNumber(value: self))
    }
}
