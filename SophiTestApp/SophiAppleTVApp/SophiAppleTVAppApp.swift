//
//  SophiAppleTVAppApp.swift
//  SophiAppleTVApp
//
//  Created by Carlos Hernández on 9/8/21.
//

import SwiftUI

@main
struct SophiAppleTVAppApp: App {
    let metrics = Metrics.shared
    var body: some Scene {
        WindowGroup {
            ContentView(metrics: metrics)
        }
    }
}
