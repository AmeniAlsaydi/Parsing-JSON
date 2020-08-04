//
//  Station.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Amy Alsaydi on 8/4/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

struct ResultsWrapper: Decodable {
    let data: StationsWrapper
}

struct StationsWrapper: Decodable {
    let stations: [Station]
}

struct Station: Decodable {
    let name: String
    let stationType: String
    let latitude: Double
    let longitude: Double
    let capacity: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stationType = "station_type"
        case latitude = "lat"
        case longitude = "lon"
        case capacity
    }
    
}
