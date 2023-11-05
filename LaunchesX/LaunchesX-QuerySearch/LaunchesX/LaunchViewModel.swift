//
//  LaunchViewModel.swift
//  LaunchesX
//
//  Created by ozan kilic on 25.04.2023.
//

import Foundation
import SpaceXAPI

class LaunchViewModel: ObservableObject{
    @Published var launches: [Launches.Launch] = []
    
    var offset = 0
    let oneTimeDataLoad = 10
    
    init(){
        fetch(with: nil)
    }
    
    func fetch(with missionName: String?){
        let queryOffset = GraphQLNullable<Int>(integerLiteral: self.offset)
        let queryLimit = GraphQLNullable<Int>(integerLiteral: self.offset + self.oneTimeDataLoad)
        let launchFind = LaunchFind(mission_name: GraphQLNullable(stringLiteral: missionName ?? ""))
        let searchQuery = LaunchSearchQuery(find: GraphQLNullable(launchFind), offset: queryOffset, limit: queryLimit)
        
        Network.shared.apollo.fetch(query: searchQuery) { result in
            switch result {
            case .success(let graphQLResult):
                if let launches = graphQLResult.data {
                    self.launches.append(contentsOf: self.process(data: launches))
                    self.offset += self.oneTimeDataLoad
                } else if let errors = graphQLResult.errors {
                    print("Hata: \(errors)")
                }
            case .failure(let error):
                print("Failure: \n\(error)")
            }
        }
    }
    
    func newSearch(with missionName: String){
        self.offset = 0
        self.launches = []
        self.fetch(with: missionName)
    }
    
    func process(data: LaunchData) -> [Launches.Launch]{
        return Launches(data).launches
    }
    
}
