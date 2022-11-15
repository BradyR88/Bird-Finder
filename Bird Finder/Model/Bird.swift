//
//  Bird.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/10/22.
//

import Foundation

struct Bird: Decodable, Identifiable {
    let id: String
    let comName: String
    let sciName: String
    let locId: String
    // let locName: String
    let obsDt: Date
    let howMany: Int?
    let lat: Double
    let lng: Double
    // let obsValid: String
    // let obsReviewed: String
    // let locationPrivate: String
    // let subId: String
    
    var dateLastSean: String {
        obsDt.formatted(date: .abbreviated, time: .shortened)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "speciesCode"
        case comName, sciName, locId, obsDt, howMany, lat, lng
    }
    
    static let example = Bird(id: "hoocro1", comName: "Hooded Crow", sciName: "Corvus cornix", locId: "L7884500", obsDt: Date(), howMany: 1, lat: 43.530936, lng: 79.455132)
}
