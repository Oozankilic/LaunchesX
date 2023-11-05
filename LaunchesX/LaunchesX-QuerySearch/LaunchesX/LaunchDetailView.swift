//
//  LaunchDetailView.swift
//  LaunchesX
//
//  Created by ozan kilic on 28.04.2023.
//

import Foundation
import SwiftUI

struct LaunchDetailView: View {
    let launch: Launches.Launch
    @State var photoURL: String?

    var body: some View {
        ZStack{
            LinearGradient(colors: [.mint, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Rocket Name: \(launch.formattedRocketName)")
                        .foregroundColor(.primary)
                        .font(.headline)
                    Text("Launch Date: \(launch.formattedDate)")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                    Text("Launch Site: \(launch.formattedSiteName)")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                    Text("Rocket Detail: \(launch.formattedRocketDescription)")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                    Text("Success: \(launch.formattedSuccess)")
                        .foregroundColor(launch.success == nil ? .primary : launch.success! ? .green : .red  )
                        .font(.subheadline)
                    AsyncImage(url: URL(string: photoURL ?? "")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("There was an error loading the image.")
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 200, height: 200)
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius:15))
            }
        }
        .navigationTitle(launch.mission)
        .task{
            await fetchRocketImageURL()
        }
    }
    
    func fetchRocketImageURL() async {
        // Wikipedia's api url to fetch main image of a given title's wikipage
        let wikipediaImageFetchURL = "https://tr.wikipedia.org/w/api.php?action=query&format=json&formatversion=2&prop=pageimages|pageterms&piprop=original&titles="
        let wikipediaTitle = launch.rocket?.detail?.wikipediaLink.components(separatedBy: "/").last ?? ""
        
        let urlString = wikipediaImageFetchURL + wikipediaTitle
        
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        if let url = URL(string: encodedString!) {
            do{
                let htmlString = try String(contentsOf: url, encoding: .utf8)
                photoURL = findSource(htmlString)
            }catch{
                print("Bad URL: \(urlString)")
            }
        } else {
            print("Bad URL: \(urlString)")
        }
    }
    
    func findSource(_ jsonString: String) -> String? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
    print("jsonData: \(String(data: jsonData, encoding: .utf8) ?? "")")
        let decoder = JSONDecoder()
        do {
            let queryResult = try decoder.decode(QueryResult.self, from: jsonData)
            print("queryResult: \(queryResult)")
            for page in queryResult.query.pages {
                if let source = page.original.source {
                    return source
                }
            }
        } catch let error {
            print("error: \(error)")
        }
        return nil
    }

    struct QueryResult: Decodable {
        let batchcomplete: Bool
        let query: QueryData
    }

    struct QueryData: Decodable {
        let normalized: [NormalizedData]
        let pages: [PageData]
    }

    struct NormalizedData: Decodable {
        let fromencoded: Bool
        let from: String
        let to: String
    }

    struct PageData: Decodable {
        let pageid: Int
        let ns: Int
        let title: String
        let original: OriginalData
        let terms: TermsData
    }

    struct OriginalData: Decodable {
        let source: String?
        let width: Int
        let height: Int
    }

    struct TermsData: Decodable {
        let label: [String]
        let description: [String]
    }
}

