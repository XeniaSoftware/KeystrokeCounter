//
//  MenuBar.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import Cocoa
import SwiftUI

// This is our custom menu that will appear when users
// click on the menu bar icon
class MainMenu: NSObject {
    var showingFloating = true
  // A new menu instance ready to add items to
  let menu = NSMenu()
  // These are the available links shown in the menu
  // These are fetched from the Info.plist file
//  let menuItems = Bundle.main.object(forInfoDictionaryKey: "KyanLinks") as! [String: String]

  // function called by KyanBarApp to create the menu
  func build() -> NSMenu {
      let launchHeatmap = NSMenuItem(
        title: "Show Heatmap",
        action: #selector(launchHeatmap),
        keyEquivalent: ""
      )
      launchHeatmap.target = self
      menu.addItem(launchHeatmap)
      
      menu.addItem(NSMenuItem.separator())

      let showSettings = NSMenuItem(
        title: "Settings",
        action: #selector(showSettings),
        keyEquivalent: ""
      )
      showSettings.target = self
      menu.addItem(showSettings)
      
//
//    // Initialse the custom now playing view
//    let countView = CountMenu()
//    // We need this to allow use to stick a SwiftUI view into a
//    // a location an NSView would normally be placed
//    let countHostingController = NSHostingController(rootView: countView)
//    // Setting a size for our now playing view
//      countHostingController.view.frame.size = CGSize(width: 150, height: 20)
//
//    // This is where we actually add our now playing view to the menu
//    let customMenuItem = NSMenuItem()
//      customMenuItem.view = countHostingController.view
//    menu.addItem(customMenuItem)
//
//    // Adding a seperator
//    menu.addItem(NSMenuItem.separator())
//
//      let floatingToggleView = ShowFloatingMenu()
//      let floatingToggleController = NSHostingController(rootView: floatingToggleView)
//      floatingToggleController.view.frame.size = CGSize(width: 150, height: 20)
////      let floatingToggleMenu = NSMenuItem()
////      floatingToggleMenu.view = floatingToggleController.view
//
//      let floatingToggleMenu = NSMenuItem(
//        title: "Show floating panel", action: #selector(toggle), keyEquivalent: "")
//      floatingToggleMenu.state = .on
//      floatingToggleMenu.target = self
////      floatingToggleMenu.title = "Show floating menu"
////      floatingToggleMenu.image = NSImage(systemSymbolName: "checkmark", accessibilityDescription: nil)
////      floatingToggleMenu.action = #selector(toggle)
////      floatingToggleMenu.isEnabled = true
//
//    // This is where we actually add our about item to the menu
//    menu.addItem(floatingToggleMenu)
//    // This is where we actually add the updates menu item we pass in
//    // Adding a seperator

      
    // Adding a quit menu item
    let quitMenuItem = NSMenuItem(
      title: "Quit KeystrokeCounter",
      action: #selector(quit),
      keyEquivalent: "q"
    )
    quitMenuItem.target = self
    menu.addItem(quitMenuItem)

      
    return menu
  }

  // The selector that takes a link and opens it
  // in your default browser
  @objc func linkSelector(sender: NSMenuItem) {
    let link = sender.representedObject as! String
    guard let url = URL(string: link) else { return }
    NSWorkspace.shared.open(url)
  }

//  // The selector that opens a standard about pane.
//  // You can see we also customise what appears in our
//  // about pane by creating a Credits.html file in the root
//  // of the project
//  @objc func about(sender: NSMenuItem) {
//    NSApp.orderFrontStandardAboutPanel()
//  }

  // The selector that quits the app
  @objc func quit(sender: NSMenuItem) {
    NSApp.terminate(self)
  }
    
    @objc func launchHeatmap(sender: NSMenuItem) {
        let foundHeatmap = NSApplication.shared.windows.reduce(into: false) { partialResult, window in
            partialResult = partialResult || window.title == Windows.Heatmap.rawValue && window.isVisible
        }
        print("FOUNDHEATMAP", foundHeatmap)
        if !foundHeatmap, let url = URL(string: "keystroke://" + Windows.Heatmap.rawValue) {
            NSWorkspace.shared.open(url)
        }
    }
    
    @objc func showSettings(sender: NSMenuItem) {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    }
}
