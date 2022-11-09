//
//  Bird_FinderApp.swift
//  Bird Finder
//
//  Created by Brady Robshaw on 10/25/22.
//

import SwiftUI

@main
struct Bird_FinderApp: App {
    var body: some Scene {
        WindowGroup {
            TabNavView()
                .environmentObject(ViewModel())
        }
    }
}
