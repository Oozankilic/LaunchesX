//
//  LaunchesXApp.swift
//  LaunchesX
//
//  Created by ozan kilic on 25.04.2023.
//

import SwiftUI

@main
struct LaunchesXApp: App {
    @StateObject var launchViewModel = LaunchViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(launchViewModel)
        }
    }
}
