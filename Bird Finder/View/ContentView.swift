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
        NavigationView {
            VStack {
                List(viewModel.hotSpots, id: \.locId) {hotSpot in
                    Text(hotSpot.locName)
                        .foregroundColor(.red)
                    NavigationLink(hotSpot.locName, destination: LocationView(hotSpot: hotSpot))
                }
                
                
                
                Button {
                    viewModel.location.requestLocationUpdates()
                } label: {
                    Text("update")
                }

            }
//            .onAppear {
//                viewModel.observeCoordinateUpdates()
//                viewModel.observeDeniedLocationAccess()
//                viewModel.location.requestLocationUpdates()
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
