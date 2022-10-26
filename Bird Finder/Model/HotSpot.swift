//
//  HotSpot.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import Foundation

struct HotSpot: Decodable {
    let locId: String
    let countryCode: String
    let subnational1Code: String
    let subnational2Code: String
    let lat: Double
    let lng: Double
    let latestObsDt: String
    let numSpeciesAllTime: Int
}
