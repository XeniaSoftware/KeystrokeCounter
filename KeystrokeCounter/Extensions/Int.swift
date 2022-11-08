//
//  String.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/7/22.
//

import Foundation

extension Int {
    func shortString() -> String {
        if self < 1000 {
            return String(self)
        }
        return String(self / 1000) + "k"
    }
}
