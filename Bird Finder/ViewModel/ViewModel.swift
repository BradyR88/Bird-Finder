//
//  ViewModel.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/26/22.
//

import Foundation
import Combine
import CoreLocation

class ViewModel: ObservableObject {
    
    @Published var hotSpots: [HotSpot] = []
    @Published var birds: [Bird] = []
    
    private var tokens: Set<AnyCancellable> = []
    var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0) {
        didSet {
//            #if targetEnvironment(simulator)
//            hotSpots = [HotSpot.example]
//            #else
            Task {
                await update(.HotSpots(lat: coordinates.latitude, lng: coordinates.longitude))
            }
//            #endif
        }
    }
    
    let location = DeviceLocationService.shared
    
    init() {
        observeCoordinateUpdates()
        observeDeniedLocationAccess()
        location.requestLocationUpdates()
    }
    
    func update(_ type: EBirdApiType)async {
        let api = APIGiter()
        
        do {
            switch type {
            case .HotSpots(_,_):
                let data:[HotSpot] = try await api.fetch(type)
                DispatchQueue.main.async {
                    self.hotSpots = data
                }
            case .ObsGeo(_,_):
                let data:[Bird] = try await api.fetch(type)
                DispatchQueue.main.async {
                    self.birds = data
                }
            case .ObsLocId(_):
                let data:[Bird] = try await api.fetch(type)
                DispatchQueue.main.async {
                    self.birds = data
                }
            }
        }
        catch {
            print("Could not fetch hotspot data \(error.localizedDescription)")
        }
    }
    
    // MARK: Combine implementation
    func observeCoordinateUpdates() {
        location.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coord in
                self.coordinates = coord
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
