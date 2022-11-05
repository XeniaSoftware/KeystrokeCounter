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
    
    var sorted: [KeyModel]
    var lastSorted: Date
    
    var total: Int {
        return getModel().total
    }
    
    init(keystrokeCollection: KeystrokeCollection = [:],
        keyboardDefinition: KeyboardDefinition = Qwerty,
        color: Color = Color(red: 1, green: 0, blue: 0)
    ) {
        self.keystrokeCollection = keystrokeCollection
        self.keyboardDefinition = keyboardDefinition
        self.color = color
        self.lastSorted = Date.distantPast
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
        return [key.topLabel, key.middleLabel, key.bottomLabel].reduce(0, {(prev, current) in
            let count = getModel().keys[current] ?? 0
            return prev+count;
        })
    }
    
    func sort() {
        self.sorted = keyboardDefinition.joined().reduce([], {(prev, current) in
            if current.isSplit {
                return prev + current.splitKeys
            }
            return prev + [current]
        }).sorted {
            getCount(for: $0) < getCount(for: $1)
        }
    }
    
    func getPercentile(key: KeyModel) -> Int {
        guard let index = sorted.firstIndex(of: key) else {
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
        let red = try container.decode(CGFloat.self, forKey: .red)
        let green = try container.decode(CGFloat.self, forKey: .green)
        let blue = try container.decode(CGFloat.self, forKey: .blue)
        self.color = Color(red: red, green: green, blue: blue)
        self.lastSorted = Date.distantPast
        self.sorted = []
        self.sort()
    }
    
    enum CodingKeys: CodingKey {
        case keystrokeCollection, keyboardDefinition, red, green, blue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(keystrokeCollection, forKey: .keystrokeCollection)
        try container.encode(keyboardDefinition, forKey: .keyboardDefinition)
        let rgb = color.rgb()
        try container.encode(rgb.red, forKey: .red)
        try container.encode(rgb.green, forKey: .green)
        try container.encode(rgb.blue, forKey: .blue)
    }

}
