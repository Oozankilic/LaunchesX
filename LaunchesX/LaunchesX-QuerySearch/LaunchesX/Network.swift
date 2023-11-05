//
//  Network.swift
//  LaunchesX
//
//  Created by ozan kilic on 25.04.2023.
//

import Foundation
import Apollo

class Network{
    static let shared = Network()
    
    let url = "https://main--spacex-l4uc6p.apollographos.net/graphql"
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: url)!)
    
    
}
