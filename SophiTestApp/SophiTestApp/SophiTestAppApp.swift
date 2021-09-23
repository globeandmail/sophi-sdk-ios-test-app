//
//  SophiSDKTestAppApp.swift
//  SophiSDKTestApp
//
//  Created by Carlos Hernández on 6/9/21.
//

import SwiftUI

@main
struct SophiTestAppApp: App {
    let metrics = Metrics.shared
    var body: some Scene {
        WindowGroup {
            ContentView(metrics: metrics)
        }
    }
}
