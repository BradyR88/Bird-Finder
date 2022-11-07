//
//  ViewModel.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/26/22.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    @Published var hotSpots: [HotSpot] = []
    
    var tokens: Set<AnyCancellable> = []
    var coordinates: (lat: Double, lon: Double) = (0, 0) {
        didSet {
            Task {
                await gitHotSpots(lat: coordinates.lat, lng: coordinates.lon)
            }
        }
    }
    
    let location = DeviceLocationService.shared
    
    init() {
        observeCoordinateUpdates()
        observeDeniedLocationAccess()
        location.requestLocationUpdates()
    }
    
    func gitHotSpots(lat: Double, lng: Double)async {
        let git = APIGiter(gitType: .NearbyHotspots)
        do {
            let data:[HotSpot] = try await git.data(lat: lat, lng: lng)
            DispatchQueue.main.async {
                self.hotSpots = data
                print("new spots")
            }
        } catch {
            print("Could not fetch hotspot data \(error.localizedDescription)")
        }
    }

    func observeCoordinateUpdates() {
        location.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coord in
                self.coordinates = (coord.latitude, coord.longitude)
            }
            .store(in: &tokens)
    }

    func observeDeniedLocationAccess() {
        location.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
            }
            .store(in: &tokens)
    }
}
