//
//  View.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import Foundation
import AppKit
import SwiftUI

extension View {
    func withHostingWindow(_ callback: @escaping (NSWindow?) -> Void) -> some View {
        self.background(HostingWindowFinder(callback: callback))
    }
}

struct HostingWindowFinder: NSViewRepresentable {
    typealias NSViewType = NSView
    
    var callback: (NSWindow?) -> ()
    
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
    }
}
