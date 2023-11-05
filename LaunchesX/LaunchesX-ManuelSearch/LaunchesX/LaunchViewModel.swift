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
    
    init(){
        fetch()
    }
    
    func fetch(){
        Network.shared.apollo.fetch(query: LaunchesQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                if let launches = graphQLResult.data {
                    self.launches = self.process(data: launches)
                } else if let errors = graphQLResult.errors {
                    print("Hata: \(errors)")
                }
            case .failure(let error):
                print("Failure: \n\(error)")
            }
        }
    }

    func process(data: LaunchData) -> [Launches.Launch]{
        return Launches(data).launches
    }
    
}
