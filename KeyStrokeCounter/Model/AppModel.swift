//
//  AppModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import Foundation
import SwiftUI

typealias KeystrokeCollection = Dictionary<String, KeyStrokeModel>
typealias KeyboardDefinition = Array<Array<KeyModel>>

class AppModel: ObservableObject, Codable {
    @Published var keystrokeCollection: KeystrokeCollection
    @Published var keyboardDefinition: KeyboardDefinition
    @Published var color: Color
    @Published var showFloatingWindow: Bool
    @Published var floatingWindowPosition: Position
    @Published var opacity: Double
    
    var sorted: [Int]
    var lastSorted: Date
    
    var total: Int {
        return getModel().total
    }
    
    init(keystrokeCollection: KeystrokeCollection = [:],
         keyboardDefinition: KeyboardDefinition = Qwerty,
         color: Color = Color(red: 1, green: 1, blue: 1),
         showFloatingWindow: Bool = false,
         floatingWindowPosition: Position = .bottomRight,
         opacity: Double = 0.7
    ) {
        self.keystrokeCollection = keystrokeCollection
        self.keyboardDefinition = keyboardDefinition
        self.color = color
        self.lastSorted = Date.distantPast
        self.showFloatingWindow = showFloatingWindow
        self.floatingWindowPosition = floatingWindowPosition
        self.opacity = opacity
        self.sorted = []
    }
    
    func getModel(for date: Date = Date()) -> KeyStrokeModel {
        let dateString = date.simpleDateString()
        let model = keystrokeCollection[dateString] ?? KeyStrokeModel()
        
        if keystrokeCollection[dateString] == nil {
            keystrokeCollection[dateString] = model
        }
        return model
    }
    
    func getCount(for key: KeyModel) -> Int {
        return [key.topLabel, key.middleLabel, key.bottomLabel].reduce(into: 0) {
            $0 += getModel().keys[$1] ?? 0
        }

    }
    
    func sort() {
        let keys = keyboardDefinition.reduce(into: [] as [KeyModel]) { prev, current in
            for keymodel in current {
                if keymodel.isSplit {
                    prev = prev + keymodel.splitKeys
                } else {
                    prev = prev + [keymodel]
                }
            }
        }
        let counts = keys.map { getCount(for: $0) }
        
        self.sorted = Array(Set(counts)).sorted()
        self.lastSorted = Date()
    }
    
    func getPercentile(key: KeyModel) -> Int {
        guard let index = sorted.firstIndex(of: getCount(for: key)) else {
            return -1
        }
        if getCount(for: key) == 0 {
            return 0
        }
        let percentile = Int((Float(index) / Float(sorted.count)) * 100);
        return percentile
    }
    
    // MARK: Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.keystrokeCollection = try container.decode(Dictionary<String, KeyStrokeModel>.self, forKey: .keystrokeCollection)
        self.keyboardDefinition = try container.decode(KeyboardDefinition.self, forKey: .keyboardDefinition)
        self.showFloatingWindow = try container.decodeIfPresent(Bool.self, forKey: .showFloating) ?? true
        let red = try container.decode(CGFloat.self, forKey: .red)
        let green = try container.decode(CGFloat.self, forKey: .green)
        let blue = try container.decode(CGFloat.self, forKey: .blue)
        self.color = Color(red: red, green: green, blue: blue)
        self.lastSorted = Date.distantPast
        self.floatingWindowPosition = try container.decodeIfPresent(Position.self, forKey: .position) ?? .bottomRight
        self.opacity = try container.decodeIfPresent(Double.self, forKey: .opacity) ?? 0.6
        self.sorted = []
        self.sort()
    }
    
    enum CodingKeys: CodingKey {
        case keystrokeCollection, keyboardDefinition, red, green, blue, showFloating, position, opacity
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keystrokeCollection, forKey: .keystrokeCollection)
        try container.encode(keyboardDefinition, forKey: .keyboardDefinition)
        let rgb = color.components
        try container.encode(rgb?[0] ?? 1, forKey: .red)
        try container.encode(rgb?[1] ?? 1, forKey: .green)
        try container.encode(rgb?[2] ?? 1, forKey: .blue)
        try container.encode(showFloatingWindow, forKey: .showFloating)
        try container.encode(floatingWindowPosition, forKey: .position)
        try container.encode(opacity, forKey: .opacity)
    }
}
