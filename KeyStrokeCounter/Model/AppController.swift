//
//  AppController.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import Foundation
import AppKit
    
class AppController: ObservableObject {
    static let shared = AppController()
    var delegate: AppDelegate? = nil
    
    @Published public var appModel: AppModel!
    private var windows: [Windows: NSWindow] = [:]
    
    init() {
        load()
    }
    
    init(appModel: AppModel) {
        self.appModel = appModel
    }
    
    func handle(event: NSEvent) {
        let model = appModel.getModel()
        model.handle(event: event)
        objectWillChange.send()
        save()
        appModel.sort()
        updateMenuBar()
    }
    
    func addWindow(for window: Windows, reference: NSWindow) {
        // If we have a different window, close it.
        if let oldWindow = self.windows[window],
           oldWindow.identifier == reference.identifier {
            oldWindow.close()
        }
        windows[window] = reference
    }
    
    private func postLoad() {
        registerEventListener()
        showFloatingWindow()
        updateMenuBar()
    }
    
    func updateMenuBar() {
        if let delegate = self.delegate {
            var total = appModel?.total ?? 0
            var menuBarString = (appModel?.useShortMenuString ?? true) ? total.shortString() : String(total)
            delegate.statusBarItem.button?.title = menuBarString
        }
    }
    
    private func registerEventListener() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)
        print("ACCESS?", accessEnabled)

        NSEvent.addGlobalMonitorForEvents(
            matching: .keyDown,
            handler: handle
        )
    }
    
    private func showFloatingWindow() {
        if appModel?.showFloatingWindow ?? false == false {
            return
        }
        if let window = windows[.Floating] {
            window.orderFrontRegardless()
        } else {
            if let url = URL(string: "keystroke://" + Windows.Floating.rawValue) {
                NSWorkspace.shared.open(url)
            }
        }
    }
    
    func showHeatmap() {
        if let window = windows[.Heatmap] {
            window.makeKeyAndOrderFront(self)
        } else {
            if let url = URL(string: "keystroke://" + Windows.Heatmap.rawValue) {
                NSWorkspace.shared.open(url)
            }
        }
    }
    
    func showSettings() {
        if let window = windows[.Settings] {
            window.makeKeyAndOrderFront(self)
        } else {
            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        }
    }
}

extension AppController {
    // MARK: Persistence
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("KeystrokeCounter.data")
    }
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                DispatchQueue.main.async {
                    self?.appModel = AppModel()
                }
                return
            }
            guard let appModel = try? JSONDecoder().decode(AppModel.self, from: data) else {
                fatalError("Can't decode saved keystroke data.")
            }
            DispatchQueue.main.async {
                self?.appModel = appModel
                self?.postLoad()
                print("LOADED")
            }
        }
    }
   
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let appModel = self?.appModel else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(appModel) else { fatalError("Error encoding data") }
            if data.count == 0 {
                fatalError("ATTEMPTING TO WRITE 0 bytes")
            }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
