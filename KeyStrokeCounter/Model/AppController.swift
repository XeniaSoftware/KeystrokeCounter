//
//  AppController.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import Foundation
import AppKit
    
class AppController: ObservableObject {
    @Published public var appModel: AppModel!
    
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
