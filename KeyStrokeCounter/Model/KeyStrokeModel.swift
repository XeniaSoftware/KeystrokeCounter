//
//  KeyStrokeModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/31/22.
//

import Foundation
import AppKit

class KeyStrokeModel: Codable {
    var keys: Dictionary<String, Int> = [:]
    var total: Int = 0
    
    func add(_ char: String) {
        keys[char] = (keys[char] ?? 0) + 1
        total += 1
    }
    
    func handle(event: NSEvent) {
        if event.isARepeat {
            return
        }
        guard let char = event.charactersIgnoringModifiers else {
            return
        }
        
        if event.modifierFlags.contains(.command) {
            add("⌘")
        }
        if event.modifierFlags.contains(.shift) {
            add("shift")
        }
        if event.modifierFlags.contains(.option) {
            add("⌥")
        }
        if event.modifierFlags.contains(.capsLock) {
            add("caps lock")
        }
        if event.modifierFlags.contains(.control) {
            add("control")
        }
        
        var found = false
        SpecialCharacters.keys.forEach { specialCharacter in
            if event.keyCode == specialCharacter {
                add(SpecialCharacters[specialCharacter]!)
                found = true
            }
        }
        if found {
            return
        }
        if event.modifierFlags.contains(.function) {
            add("fn")
        }
        if char[char.startIndex].isLetter {
            add(char.uppercased())
        } else {
            add(char)
        }
    }
}
