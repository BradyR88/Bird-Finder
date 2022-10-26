//
//  ContentView.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            Task {
                let giter = APIGiter(gitType: .NearbyHotspots)
                let data:[HotSpot] = try! await giter.data()
                print(data)
            }
           
        } label: {
            Text("Test")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
