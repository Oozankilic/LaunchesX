//
//  LaunchView.swift
//  LaunchesX
//
//  Created by ozan kilic on 28.04.2023.
//

import Foundation
import SwiftUI

struct LaunchCardView: View {
    let launch: Launches.Launch
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(launch.mission)
                .font(.headline)
            Text("Date: \(launch.formattedDate)")
                .foregroundColor(.primary)
                .font(.subheadline)
            Text("Launch Site: \(launch.formattedSiteName)")
                .foregroundColor(.primary)
                .font(.subheadline)
            Text("Success: \(launch.formattedSuccess)")
                .foregroundColor(launch.success == nil ? .primary : launch.success! ? .green : .red  )
                .font(.subheadline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .scrollContentBackground(.hidden)
    }
}


