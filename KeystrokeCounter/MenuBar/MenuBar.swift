//
//  MenuBar.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import Cocoa
import SwiftUI

class MainMenu: NSObject {
    var showingFloating = true
    let menu = NSMenu()
    let appController = AppController.shared

    func build() -> NSMenu {
        addCount(to: menu)
        addSeperator(to: menu)

        addShowHeatmap(to: menu)
        addSeperator(to: menu)

        addShowSettings(to: menu)
        addQuit(to: menu)
      
        return menu
    }
    
    func addSeperator(to menue: NSMenu) {
        menu.addItem(NSMenuItem.separator())
    }
    
    func addCount(to menu: NSMenu) {
        let countMenuItem = NSMenuItem()
        countMenuItem.isEnabled = false
        let countHostingController = NSHostingController(rootView: CountMenu())
        countMenuItem.view = countHostingController.view
        countHostingController.view.frame.size = CGSize(width: 150, height: 20)
        menu.addItem(countMenuItem)
    }
    
    func addShowHeatmap(to menu: NSMenu) {
        let launchHeatmap = NSMenuItem(
            title: "Show Heatmap",
            action: #selector(launchHeatmap),
            keyEquivalent: ""
        )
        launchHeatmap.target = self
        menu.addItem(launchHeatmap)
    }
    
    func addShowSettings(to menu: NSMenu) {
        let showSettings = NSMenuItem(
            title: "Settings",
            action: #selector(showSettings),
            keyEquivalent: ""
        )
        showSettings.target = self
        menu.addItem(showSettings)
    }
    
    func addQuit(to menu: NSMenu) {
        let quitMenuItem = NSMenuItem(
            title: "Quit KeystrokeCounter",
            action: #selector(quit),
            keyEquivalent: "q"
        )
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
    }

    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
    
    @objc func launchHeatmap(sender: NSMenuItem) {
        appController.showHeatmap()
    }
    
    @objc func showSettings(sender: NSMenuItem) {
        appController.showSettings()
    }
}
