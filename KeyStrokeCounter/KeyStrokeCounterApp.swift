//
//  KeyStrokeCounterApp.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

@main
struct KeyStrokeCounterApp: App {
    @ObservedObject private var appController = AppController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appController)
        }
    }
}
