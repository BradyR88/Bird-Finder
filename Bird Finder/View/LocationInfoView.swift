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
            Text("\(viewModel.birds.count)")
            
            List(viewModel.birds, id: \.self) { bird in
                Text(bird)
            }
        }
        .navigationTitle(spot.locName)
        .onAppear {
            Task {
                await viewModel.gitSpotInfo(locId: spot.id)
            }
        }
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(spot: HotSpot.example)
    }
}
