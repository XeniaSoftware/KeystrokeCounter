//
//  NSWindow.swift
//  KeystrokeCounter
//
//  Created by William Staggs on 11/10/22.
//

import Foundation
import AppKit

extension NSWindow {
    func focus() {
        self.orderFrontRegardless()
        self.makeKey()
        self.makeMain()
    }
}
