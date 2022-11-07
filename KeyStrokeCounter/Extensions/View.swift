//
//  View.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import Foundation
import AppKit
import SwiftUI


struct WindowAccessor: NSViewRepresentable {
    @Binding var window: NSWindow?
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.window = view.window
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

public extension View {
    // Get rect of a view in specified coordinate space, by default in global, so by default it
    // provides view's frame in window coordinates, to have bounds specify .local, to have in some
    // parent provide named coordinate space correspondingly.
    func cgRect(_ binding: Binding<CGRect?>, _ space: CoordinateSpace = .global) -> some View {
        self.background(rectReader(binding, space))
    }
    
    func window(_ binding: Binding<NSWindow?>) -> some View {
        self.background(WindowAccessor(window: binding))
    }
}

func rectReader(_ binding: Binding<CGRect?>, _ space: CoordinateSpace = .global) -> some View {
    GeometryReader { (geometry) -> Color in
        let rect = geometry.frame(in: space)
        DispatchQueue.main.async {
            binding.wrappedValue = rect
        }
        return .clear
    }
}
