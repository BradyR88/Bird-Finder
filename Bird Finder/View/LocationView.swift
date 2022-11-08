//
//  LocationView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/7/22.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
    
    let hotSpot: HotSpot
    
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: [hotSpot]) { spot in
            MapMarker(coordinate: spot.coordinate)
        }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                region.center = viewModel.coordinates
            }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(hotSpot: HotSpot.example)
            .environmentObject(ViewModel())
    }
}
