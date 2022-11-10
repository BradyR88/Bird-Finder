//
//  LocationInfoView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/10/22.
//

import SwiftUI

struct LocationInfoView: View {
    let spot: HotSpot
    
    var body: some View {
        VStack {
            Text("\(spot.numSpeciesAllTime) all time species.")
            Text(spot.latestObsDt.description)
        }
        .navigationTitle(spot.locName)
    }
}

struct LocationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationInfoView(spot: HotSpot.example)
    }
}
