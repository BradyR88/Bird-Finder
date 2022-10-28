//
//  ViewModel.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/26/22.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var hotSpots: [HotSpot] = []
    
    var location = DeviceLocationService.shared
    
    func gitHotSpots(lat: Double, lng: Double)async {
        let git = APIGiter(gitType: .NearbyHotspots)
        do {
            let data:[HotSpot] = try await git.data(lat: lat, lng: lng)
            DispatchQueue.main.async {
                self.hotSpots = data
            }
        } catch {
            print("Could not fetch hotspot data \(error.localizedDescription)")
        }
    }
}
