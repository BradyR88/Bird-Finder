//
//  LocationInfoView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/10/22.
//

import SwiftUI

struct LocationInfoView: View {
    @EnvironmentObject var viewModel: ViewModel
    let spot: HotSpot
    
    var body: some View {
        VStack {
            Text("\(spot.numSpeciesAllTime) all time species.")
            Text(spot.latestObsDt.description)
            
            List(viewModel.birds) { bird in
                Text(bird.comName)
            }
        }
        .navigationTitle(spot.locName)
        .onAppear {
            Task {
                await viewModel.gitSpotInfo(lat: spot.lat, lng: spot.lng)
            }
        }
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(spot: HotSpot.example)
    }
}
