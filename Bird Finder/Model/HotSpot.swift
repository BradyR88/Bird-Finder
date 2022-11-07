//
//  HotSpot.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import Foundation

struct HotSpot: Decodable {
    let locId: String
    let locName: String
    let countryCode: String
    let subnational1Code: String
    let subnational2Code: String
    let lat: Double
    let lng: Double
    let latestObsDt: String
    let numSpeciesAllTime: Int
    
    static let example = HotSpot(locId: "L283548", locName: "A. J. Henry Park", countryCode: "US", subnational1Code: "US-FL", subnational2Code: "US-FL-073", lat: 30.5064607, lng: -84.2159428, latestObsDt: "2022-10-22 08:38", numSpeciesAllTime: 142)
}
