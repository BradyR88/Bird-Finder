//
//  TabNavView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 11/9/22.
//

import SwiftUI

struct TabNavView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                MapView()
                    .tabItem {
                        Label("Map", systemImage: "map")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.location.requestLocationUpdates()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }

                }
            }
        }
    }
}

struct TabNavView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavView()
            .environmentObject(ViewModel())
    }
}
