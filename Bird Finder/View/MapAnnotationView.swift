//
//  MapAnnotationView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/9/22.
//

import SwiftUI

struct MapAnnotationView: View {
    let hotSpot: HotSpot
    
    var body: some View {
        NavigationLink {
            EmptyView()
        } label: {
            VStack(spacing: 0) {
                ZStack {
                    Image(systemName: "circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                    
                    Image(systemName: "mappin.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
                
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .offset(x: 0, y: -5)
            }
        } 
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(hotSpot: HotSpot.example)
    }
}
