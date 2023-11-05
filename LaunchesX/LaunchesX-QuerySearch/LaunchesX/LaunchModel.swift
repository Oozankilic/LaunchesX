//
//  LaunchModel.swift
//  LaunchesX
//
//  Created by ozan kilic on 25.04.2023.
//

import Foundation
import SpaceXAPI

typealias LaunchData = LaunchSearchQuery.Data

struct Launches: Decodable {
    var launches: [Launch]

    init(_ launches: LaunchData?) {
        self.launches = launches?.launches?.compactMap({ launch -> Launches.Launch in
            Launch(launch)
        }) ?? []
    }

    struct Launch: Identifiable, Decodable {
        var id: String
        var mission: String
        var success: Bool?
        var date: String?
        var site: Site?
        var rocket: Rocket?

        init(_ launch: LaunchData.Launch?) {
            self.id = launch?.id ?? ""
            self.mission = launch?.mission_name ?? ""
            self.success = launch?.launch_success
            self.date = launch?.launch_date_local
            self.site = Site(launch?.launch_site)
            self.rocket = Rocket(launch?.rocket)
        }
        
        struct Site: Decodable{
            var siteName: String?
            
            init(_ site: LaunchData.Launch.Launch_site?){
                self.siteName = site?.site_name
            }
        }
        
        struct Rocket: Decodable {
            var name: String?
            var detail: RocketDetail?

            init (_ rocket: LaunchData.Launch.Rocket?) {
                self.name = rocket?.rocket_name
                self.detail = RocketDetail(rocket?.rocket)
            }
            
            struct RocketDetail: Decodable {
                var description: String
                var wikipediaLink: String
                
                init( _ details: LaunchData.Launch.Rocket.Rocket?){
                    self.description = details?.description ?? ""
                    self.wikipediaLink = details?.wikipedia ?? ""
                }
            }
        
        }
    }
}


extension Launches.Launch {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: date!) else {
            return "Data not provided"
        }
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    var formattedSuccess: String {
        switch success {
        case .some(true):
            return "Success"
        case .some(false):
            return "Fail"
        case .none:
            return "Data not provided"
        }
    }
    
    var formattedSiteName: String {
        site?.siteName ?? "Data not provided"
    }
    
    var formattedRocketName: String {
        rocket?.name ?? "Data not provided"
    }
    
    var formattedRocketDescription: String{
        rocket?.detail?.description ?? "Data not provided"
    }
    
    
}





