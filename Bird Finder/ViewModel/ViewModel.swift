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
            #if targetEnvironment(simulator)
            hotSpots = [HotSpot.example]
            #else
            Task {
                await gitHotSpots(lat: coordinates.latitude, lng: coordinates.longitude)
            }
            #endif
        }
    }
    
    let location = DeviceLocationService.shared
    
    init() {
        observeCoordinateUpdates()
        observeDeniedLocationAccess()
        location.requestLocationUpdates()
    }
    
    func gitHotSpots(lat: Double, lng: Double)async {
        let git = APIGiter()
        do {
            let data = try await git.hotSpotApi(lat: lat, lng: lng)
            DispatchQueue.main.async {
                self.hotSpots = data
                print("new spots")
            }
        } catch {
            print("Could not fetch hotspot data \(error.localizedDescription)")
        }
    }
    
//    func gitBirdsNearPoint(lat: Double, lng: Double)async {
//        let git = APIGiter()
//        do {
//            let data = try await git.obsGeoApi(lat: lat, lng: lng)
//            DispatchQueue.main.async {
//                self.opservations = data
//                print("new birds")
//                print(data)
//            }
//        } catch {
//            print("Could not fetch hotspot data \(error.localizedDescription)")
//        }
//    }
    
    func gitSpotInfo(locId: String)async {
        let git = APIGiter()
        do {
            let data = try await git.sppListApi(locId: locId)
            DispatchQueue.main.async {
                self.birds = data
                print("new birds")
            }
        } catch {
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
    
    enum Update {
    case hotSpots, birds, opservations
    }
}
