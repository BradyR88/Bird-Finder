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
            List(viewModel.hotSpots) {hotSpot in
                NavigationLink(hotSpot.locName, destination: LocationInfoView(spot: hotSpot))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
