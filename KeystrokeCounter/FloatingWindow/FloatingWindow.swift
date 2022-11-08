//
//  FloatingWindow.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import SwiftUI
import AppKit

let FloatingWindowWidth = 100
let FloatingWindowHeight = 25

struct FloatingWindow: View {
    @EnvironmentObject var appController: AppController
    @State private var window: NSWindow?

    var body: some View {
        VStack {
            Text(String(appController.appModel?.total ?? 0))
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .frame(width: CGFloat(FloatingWindowWidth), height: CGFloat(FloatingWindowHeight))
                .padding(.bottom)
                .background(WindowAccessor(window: $window))
                .onChange(of: window, perform: { newValue in
                    if let opacity = appController.appModel?.opacity {
                        window?.alphaValue = opacity
                    }
                    window?.level = .floating
                    window?.standardWindowButton(.zoomButton)?.isHidden = true
                    window?.standardWindowButton(.closeButton)?.isHidden = true
                    window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    window?.isMovableByWindowBackground = true
                    window?.isMovable = false
                    window?.ignoresMouseEvents = true
                })
                .onChange(of: appController.appModel?.opacity, perform: { opacity in
                    if opacity != nil {
                        window?.alphaValue = opacity!
                    }
                })
                .padding(.bottom, 8)
        }
        .window($window)
        .onChange(of: appController.appModel?.showFloatingWindow) { showWindow in
            window?.close()
        }
        .onChange(of: window) { window in
            if let floating = window {
                appController.addWindow(for: .Floating, reference: floating)
            }
            positionSelf()
        }
        .onChange(of: appController.appModel?.floatingWindowPosition) { position in
            positionSelf()
        }
    }
    
    func positionSelf() {
        guard let mainScreen = NSScreen.main else {
            assertionFailure()
            return
        }
        let mainScreenFrame = mainScreen.frame
        let mainScreenVisibleFrame = mainScreen.visibleFrame
        let screenWidth = mainScreenVisibleFrame.width
//        let screenHeight = mainScreenVisibleFrame.height
        let offset = mainScreenFrame.height - mainScreenVisibleFrame.height
        var newFrame: NSRect? = nil
        
        switch appController.appModel?.floatingWindowPosition {
        case .bottomRight:
            newFrame = NSRect(
                x: Int(screenWidth) - FloatingWindowWidth,
                y: FloatingWindowHeight + Int(offset) - 11,
                width: FloatingWindowWidth,
                height: FloatingWindowHeight
            )
        case .bottomLeft:
            newFrame = NSRect(
                x: 0,
                y: FloatingWindowHeight + Int(offset) - 11,
                width: FloatingWindowWidth,
                height: FloatingWindowHeight
            )
        case .none:
            return
        }
        
        if newFrame != nil {
            window?.setFrame(newFrame!, display: true)
        }
    }
}

struct FloatingWindow_Previews: PreviewProvider {
    static var previews: some View {
        FloatingWindow()
    }
}
