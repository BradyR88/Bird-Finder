//
//  ContentView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            List(viewModel.hotSpots, id: \.locId) { hotSpot in
                Text(hotSpot.locId)
            }
            Button {
                viewModel.location.requestGeolocationPermission()
            } label: {
                Text("Request")
            }
            Button {
                Task {
                    await viewModel.gitHotSpots()
                }
            } label: {
                Text("Git")
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
