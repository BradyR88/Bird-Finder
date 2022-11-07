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
    
    var body: some View {
        VStack {
//            Text("Latitude: \(coordinates.lat)")
//                .font(.largeTitle)
//            Text("Longitude: \(coordinates.lon)")
//                .font(.largeTitle)
            
            List(viewModel.hotSpots, id: \.locId) {hotSpot in
                Text(hotSpot.locId)
            }
            
            Button {
                viewModel.observeCoordinateUpdates()
                viewModel.location.requestLocationUpdates()
            } label: {
                Text("update")
            }

        }
        .onAppear {
            viewModel.observeCoordinateUpdates()
            viewModel.observeDeniedLocationAccess()
            viewModel.location.requestLocationUpdates()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
