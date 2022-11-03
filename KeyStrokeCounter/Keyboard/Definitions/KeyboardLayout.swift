//
//  KeyboardLayout.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/2/22.
//

import Foundation

typealias KeyboardDefinition = Array<Array<KeyModel>>

struct KeyboardLayout {
    public let definition: KeyboardDefinition
    public var sorted: [KeyModel] = []
    
    init(definition: KeyboardDefinition) {
        self.definition = definition
    }
    
    mutating func sort() {
        self.sorted = Array(definition.joined()).sorted()
    }
    
    public func getPercentile(key: KeyModel) -> Int {
//        print("GETTING PERCENTILE", key.middleLabel, key.bottomLabel, self.sorted.debugDescription)
        guard let index = sorted.firstIndex(of: key) else {
            return -1
        }
        if key.keyCount == 0 {
            return 0
        }
        let percentile = Int((Float(index) / Float(sorted.count)) * 100);
//        print(key.middleLabel,key.keyCount, index, percentile)
        return percentile
    }
}

