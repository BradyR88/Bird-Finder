//
//  APIGiter.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//
import Foundation

struct APIGiter {
    
    func fetch<T: Decodable>(_ type: EBirdApiType)async throws -> T {
        let urlString: String
        
        switch type {
        case .HotSpots(let lat, let lng):
            urlString = "https://api.ebird.org/v2/ref/hotspot/geo?lat=\(lat)&lng=\(lng)&fmt=json&back=7"
        case .ObsGeo(let lat, let lng):
            urlString = "https://api.ebird.org/v2/data/obs/geo/recent?lat=\(lat)&lng=\(lng)&key=\(SecretConstance.eBirdApiKey)&dist=3"
        case .ObsLocId(let locId):
            urlString = "https://api.ebird.org/v2/data/obs/\(locId)/recent?key=\(SecretConstance.eBirdApiKey)"
        }
        
        return try await data(from: urlString)
    }
    
    private func data<T: Decodable>(from urlString: String)async throws -> T {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let data = try await URLSession.shared.decode(T.self, from: url, dateDecodingStrategy: .formatted(dateFormatter))
        print("parsed data \(data)")
        return data
    }
}

enum EBirdApiType {
    case HotSpots(lat: Double, lng: Double)
    case ObsGeo(lat: Double, lng: Double)
    case ObsLocId(locId: String)
}
