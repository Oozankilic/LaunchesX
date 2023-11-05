//
//  ContentView.swift
//  LaunchesX
//
//  Created by ozan kilic on 25.04.2023.
//

import SwiftUI
import Apollo
import SpaceXAPI

struct ContentView: View {
    @State var searchText: String = ""
    @EnvironmentObject var launchViewModel: LaunchViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    LinearGradient(colors: [.mint, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                    if searchResults.isEmpty {
                        Text("No launches found.")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.top, 32)
                    } else {
                        List {
                            ForEach(searchResults, id: \.self.mission) { launch in
                                NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                    LaunchCardView(launch: launch)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("SpaceX Launches")
        }
        .searchable(text: $searchText, prompt: "Search for mission name")
        .disableAutocorrection(true)
    }

    var searchResults: [Launches.Launch] {
        if searchText.isEmpty {
            return launchViewModel.launches
        } else {
            return launchViewModel.launches.filter { $0.mission.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchViewModel())
    }
}
