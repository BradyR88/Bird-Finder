//
//  LocationView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/7/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.none), annotationItems: viewModel.hotSpots) { spot in
            
                MapAnnotation(coordinate: spot.coordinate) {
                    MapAnnotationView(hotSpot: spot)
                }
            }
            //.edgesIgnoringSafeArea(.all)
            .onAppear {
                region.center = viewModel.coordinates
            }
            .navigationBarTitleDisplayMode(.inline)
            .overlay {
                Color.clear
                    .background(.regularMaterial)
                    .frame(height: 45)
                    .frame(maxHeight: .infinity, alignment: .top)
            }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(ViewModel())
    }
}
