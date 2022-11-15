//
//  HotSpot.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import Foundation
import CoreLocation

struct HotSpot: Decodable, Equatable, Identifiable {
    let id: String
    let locName: String
    let countryCode: String
    let subnational1Code: String
    let subnational2Code: String
    let lat: Double
    let lng: Double
    let latestObsDt: Date
    let numSpeciesAllTime: Int
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    var dateFormated: String {
        latestObsDt.formatted(date: .abbreviated, time: .omitted)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "locId"
        case locName, countryCode, subnational1Code, subnational2Code, lat, lng, latestObsDt, numSpeciesAllTime
    }
    
    static let example = HotSpot(id: "L283548", locName: "A. J. Henry Park", countryCode: "US", subnational1Code: "US-FL", subnational2Code: "US-FL-073", lat: 30.5064607, lng: -84.2159428, latestObsDt: Date(), numSpeciesAllTime: 142)
}
