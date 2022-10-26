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
    
    func gitHotSpots()async {
        if location.authorizationState == .authorizedAlways || location.authorizationState == .authorizedWhenInUse {
            let git = APIGiter(gitType: .NearbyHotspots)
            do {
                let data:[HotSpot] = try await git.data()
                DispatchQueue.main.async {
                    self.hotSpots = data
                }
                print(hotSpots)
            } catch {
                print("Could not fetch hotspot data \(error.localizedDescription)")
            }
        } else {
            location.requestGeolocationPermission()
        }
    }
}
