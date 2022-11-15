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
            Text("\(viewModel.birds.count) species in the last 30 days.")
            
            
            List(viewModel.birds) { bird in
                Text("\(bird.comName) - \(bird.dateLastSean)") 
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
            .environmentObject(ViewModel())
    }
}
