//
//  KeyStrokeCollectionModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/31/22.
//

import Foundation
import AppKit

class KeyStrokeCollectionModel: ObservableObject {
    static let shared = KeyStrokeCollectionModel(layout: KeyboardLayout(definition: Qwerty))
    
    @Published var keystrokeCollection: Dictionary<String, KeyStrokeModel> = [:] {
        didSet {
            layout.sort()
        }
    }
    
    @Published var layout: KeyboardLayout
    
    private var lastSorted: Date
    
    init(layout: KeyboardLayout, shouldLoad: Bool = true) {
        self.layout = layout
        self.lastSorted = Date()
        if shouldLoad {
            load()
        }
    }
    
    var total: Int {
        return getModel().total
    }
    
    func todayAsString() -> String {
        let today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter .dateStyle = DateFormatter.Style.short

        return dateFormatter.string(from: today)
    }
    
    func getModel() -> KeyStrokeModel {
        let todayString = todayAsString()
        let model = keystrokeCollection[todayString] ?? KeyStrokeModel()
        
        if keystrokeCollection[todayString] == nil {
            keystrokeCollection[todayString] = model
        }
        
        return model
    }
    
    func getCount(chars: Array<String>) -> Int {
        return chars.reduce(0, {(prev, current) in
            let count = getModel().keys[current] ?? 0
            return prev+count;
        })
    }
    
    func handle(event: NSEvent) {
        let model = getModel()
        model.handle(event: event)
        objectWillChange.send()
        save()
        let distance = Date().timeIntervalSince(lastSorted)
        print("TIME SINCE", distance)
        if distance > Double(10) {
            layout.sort()
            self.lastSorted = Date()
        }
    }
}

extension KeyStrokeCollectionModel {
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
                return
            }
            guard let collections = try? JSONDecoder().decode(Dictionary<String, KeyStrokeModel>.self, from: data) else {
                fatalError("Can't decode saved keystroke data.")
            }
            DispatchQueue.main.async {
                self?.keystrokeCollection = collections
                print("LOADED")
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let collections = self?.keystrokeCollection else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(collections) else { fatalError("Error encoding data") }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file")
            }
        }
    }
}
