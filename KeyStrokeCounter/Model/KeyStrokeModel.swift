//
//  KeyStrokeModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/31/22.
//

import Foundation
import AppKit

class KeyStrokeModel: Codable {
    var keystrokes: Dictionary<String, Int> = [:]
    var total: Int {
        keystrokes.values.reduce(0, {(prev, current) -> Int in
            return prev + current
        })
    }
    
    func handle(event: NSEvent) {
        guard let char = event.characters else {
            return
        }
        if keystrokes[char] == nil {
            keystrokes[char] = 0
        }
        
        keystrokes[char] = (keystrokes[char] ?? 0) + 1
    }
}
