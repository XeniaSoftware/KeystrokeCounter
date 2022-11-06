//
//  KeyStrokeCounterApp.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

@main
struct KeyStrokeCounterApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject private var appController = AppController()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appController)
        }
        .windowStyle(.hiddenTitleBar)
    }
}
