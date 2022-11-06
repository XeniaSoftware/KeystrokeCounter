//
//  FloatingWindow.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import SwiftUI
import AppKit

struct FloatingWindow: View {
    @EnvironmentObject var appController: AppController

    var body: some View {
        VStack {
            Text(String(appController.appModel?.total ?? 0))
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .frame(width: 100, height: 25)
                .padding(.bottom)
                .withHostingWindow { window in
                    print("FOUND WINDOW")
                    window?.alphaValue = 0.7
                    window?.level = .floating
                    window?.standardWindowButton(.zoomButton)?.isHidden = true
                    window?.standardWindowButton(.closeButton)?.isHidden = true
                    window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
                    window?.isMovableByWindowBackground = true
                }
                .padding(.bottom, 8)
        }
    }
}



struct FloatingWindow_Previews: PreviewProvider {
    static var previews: some View {
        FloatingWindow()
    }
}
