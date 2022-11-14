//
//  Keyboard.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var appController: AppController
    @State var showLabels = false

    var body: some View {
        VStack(spacing: appController.appModel.keySpacing) {
            ForEach(appController.appModel.keyboardDefinition, id: \.self) { row in
                HStack(spacing: appController.appModel.keySpacing) {
                    ForEach(row, id: \.self) { key in
                        if key.isSplit {
                            VStack(spacing: 0) {
                                ForEach(key.splitKeys) { splitKey in
                                    Key(model: splitKey, showLabels: $showLabels)
                                }
                            }
                        }
                        else {
                            Key(model: key, showLabels: $showLabels)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
                self.showLabels = event.modifierFlags.contains(.option)
                return event
            }
        }
        
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
    }
}
