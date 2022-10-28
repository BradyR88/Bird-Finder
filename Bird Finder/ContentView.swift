//
//  ContentView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import Combine
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @StateObject var deviceLocationService = DeviceLocationService.shared

    @State var tokens: Set<AnyCancellable> = []
    @State var coordinates: (lat: Double, lon: Double) = (0, 0) {
        didSet {
            Task {
                await viewModel.gitHotSpots(lat: coordinates.lat, lng: coordinates.lon)
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Latitude: \(coordinates.lat)")
                .font(.largeTitle)
            Text("Longitude: \(coordinates.lon)")
                .font(.largeTitle)
            
            List(viewModel.hotSpots, id: \.locId) {hotSpot in
                Text(hotSpot.locId)
            }
            
            Button {
                deviceLocationService.requestLocationUpdates()
            } label: {
                Text("update")
            }

        }
        .onAppear {
            observeCoordinateUpdates()
            observeDeniedLocationAccess()
            deviceLocationService.requestLocationUpdates()
        }
    }
    
    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                self.coordinates = (coordinates.latitude, coordinates.longitude)
            }
            .store(in: &tokens)
    }

    func observeDeniedLocationAccess() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
            }
            .store(in: &tokens)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
