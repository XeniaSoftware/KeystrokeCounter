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
        WindowGroup("Keyboard") {
            MainView()
                .environmentObject(appController)
        }
        .windowStyle(.hiddenTitleBar)

        WindowGroup("Floating") {
                FloatingWindow()
                    .environmentObject(appController)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
//        .windowStyle(.hiddenTitleBar)
        .handlesExternalEvents(matching: Set(arrayLiteral: "*"))
    }
}
