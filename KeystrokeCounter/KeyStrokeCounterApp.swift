//
//  KeyStrokeCounterApp.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

@main
struct KeyStrokeCounterApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject private var appController = AppController.shared
    
    var body: some Scene {
        WindowGroup(Windows.Heatmap.rawValue) {
            MainView()
                .environmentObject(appController)
        }
        .commands {
            CommandGroup(replacing: .newItem, addition: { })
        }
        .windowStyle(.hiddenTitleBar)
        .handlesExternalEvents(matching: Set(arrayLiteral: Windows.Heatmap.rawValue))

        WindowGroup(Windows.Floating.rawValue) {
                FloatingWindow()
                    .environmentObject(appController)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .handlesExternalEvents(matching: Set(arrayLiteral: Windows.Floating.rawValue))
        
        Settings {
            SettingsView()
                .environmentObject(appController)
        }
    }
}

// Our AppDelegae will handle our menu
class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate!

    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu = MainMenu()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppDelegate.instance = self
        AppController.shared.delegate = self
        NSWindow.allowsAutomaticWindowTabbing = false

        statusBarItem.button?.title = String(AppController.shared.appModel?.total ?? 0)
        statusBarItem.menu = menu.build()
        NSApplication.shared.activate(ignoringOtherApps: true)
    }
}
