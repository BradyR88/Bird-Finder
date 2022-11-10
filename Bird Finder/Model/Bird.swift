//
//  Bird.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/10/22.
//

import Foundation

struct Bird: Decodable, Identifiable {
    let speciesCode: String
    let comName: String
    let sciName: String
    let id: String
    // let locName: String
    let obsDt: Date
    let howMany: Int
    let lat: Double
    let lng: Double
    // let obsValid: String
    // let obsReviewed: String
    // let locationPrivate: String
    // let subId: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "locId"
        case speciesCode, comName, sciName, obsDt, howMany, lat, lng
    }
    
    static let example = Bird(speciesCode: "hoocro1", comName: "Hooded Crow", sciName: "Corvus cornix", id: "L7884500", obsDt: Date(), howMany: 1, lat: 43.530936, lng: 79.455132)
}
