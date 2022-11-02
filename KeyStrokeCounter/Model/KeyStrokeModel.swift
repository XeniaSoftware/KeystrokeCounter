//
//  KeyStrokeModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/31/22.
//

import Foundation
import AppKit

class KeyStrokeModel: Codable {
    var chars: Dictionary<String, Int> = [:]
    var symbols: Dictionary<String, Int> = [:]
    var numbers: Dictionary<String, Int> = [:]
    var modifiers: Dictionary<String, Int> = [:]
    
    var total: Int {
        let charCount = chars.values.reduce(0, {(prev, current) -> Int in
            return prev + current
        })
        let symbolCount = symbols.values.reduce(0, {(prev, current) -> Int in
            return prev + current
        })
        let modifierCount = modifiers.values.reduce(0, {(prev, current) -> Int in
            return prev + current
        })
        return charCount + symbolCount + modifierCount
    }
    
    func add(char: String) {
        chars[char] = (chars[char] ?? 0) + 1
    }
    
    func add(modifier: String) {
        modifiers[modifier] = (modifiers[modifier] ?? 0) + 1
    }
    
    func add(symbol: String) {
        symbols[symbol] = (symbols[symbol] ?? 0) + 1
    }
    
    func add(number: String) {
        numbers[number] = (numbers[number] ?? 0) + 1
    }
    
    func handle(event: NSEvent) {
        if event.isARepeat {
            return
        }
        guard let char = event.charactersIgnoringModifiers else {
            return
        }
        print("KEYCODE: " + String(event.keyCode))
        print("CHAR: " + char)

        
        if event.modifierFlags.contains(.command) {
            add(modifier: "COMMAND")
        }
        if event.modifierFlags.contains(.shift) {
            add(modifier: "SHIFT")
        }
        if event.modifierFlags.contains(.option) {
            add(modifier: "OPTION")
        }
        if event.modifierFlags.contains(.capsLock) {
            add(modifier: "CAPSLOCK")
        }
        if event.modifierFlags.contains(.control) {
            add(modifier: "CONTROL")
        }
        var found = false
        SpecialCharacters.keys.forEach { specialCharacter in
            if event.keyCode == specialCharacter {
                add(modifier: SpecialCharacters[specialCharacter]!)
                found = true
            }
        }
        if found {
            return
        }
        if event.modifierFlags.contains(.function) {
            add(modifier: "Fn")
        }
        if char[char.startIndex].isLetter {
            add(char: char.lowercased())
        } else if char[char.startIndex].isNumber {
            add(number: char)
        } else {
            print(char.debugDescription)
            add(symbol: char)
        }
    }
}
