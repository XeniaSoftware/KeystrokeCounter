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
    
    init(definition: KeyboardDefinition) {
        self.definition = definition
    }
    
    public func getPercentile(key: KeyModel) -> Int {
        print("GETTING PERCENTILE", key.middleLabel, key.bottomLabel)
        let sorted = Array(definition.joined()).sorted { (lhs, rhs) in
            return lhs.keyCount < rhs.keyCount
        }
        guard let index = sorted.firstIndex(of: key) else {
            return -1
        }
        let percentile = Int((Float(index) / Float(sorted.count)) * 100);
        print(key.middleLabel,key.keyCount, index, percentile)
        return percentile
    }
}
