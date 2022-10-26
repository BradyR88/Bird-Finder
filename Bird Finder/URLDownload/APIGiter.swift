//
//  APIGiter.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//
import Foundation

struct APIGiter {
    let gitType: GitType
    
    func data<T: Decodable>()async throws -> T {
        switch gitType {
        case .NearbyHotspots:
            let lat = String(30.4383)
            let lng = String(-84.2807)
            
            let urlString = "https://api.ebird.org/v2/ref/hotspot/geo?lat=\(lat)&lng=\(lng)&fmt=json"
            guard let url = URL(string: urlString) else { throw URLError(.badURL) }
            let data = try await URLSession.shared.decode(T.self, from: url)
            return data
        }
    }
    
    enum GitType {
    case NearbyHotspots
    }
}

