//
//  TeamsTabBarViewModel.swift
//  Dota2 plus
//
//  Created by Diego Monteagudo Diaz on 8/03/23.
//

import SwiftUI

class TeamTabBarViewModel: ObservableObject {
    var fetchedTeams = [TeamModel]() {
        didSet {
            dataConstruction()
        }
    }
    @Published var topFiveTeams = [TeamModel]()
    @Published var teams = [TeamModel]()
    var service: DotaApiServiceProtocol!
    
    init(service: DotaApiServiceProtocol) {
        self.service = service
    }
    
    
    
    func fetchTeamData() {
        let request = Resource<[TeamModel]>(url: Constants.Urls.teams) { data in
            let decoded = try? JSONDecoder().decode([TeamModel].self, from: data)
            guard let decoded = decoded else {
                return []
            }
            return decoded
        }
        
        Task {
            await service.fetchData(request: request) { data in
                if var result = data {
                    result.removeAll { $0.name == "" }
                    result.removeAll { $0.name.contains("CyberBonch")}
                    var resultPrefix = Array(result.prefix(100))
                    self.orderConstruction(&resultPrefix)
                    self.fetchedTeams = resultPrefix
                }
            }
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
