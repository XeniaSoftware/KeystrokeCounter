//
//  Keyboard.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var appController: AppController

    var body: some View {
        VStack(spacing: appController.appModel.keySpacing) {
            ForEach(appController.appModel.keyboardDefinition, id: \.self) { row in
                HStack(spacing: appController.appModel.keySpacing) {
                    ForEach(row, id: \.self) { key in
                        if key.isSplit {
                            VStack(spacing: 0) {
                                ForEach(key.splitKeys) { splitKey in
                                    Key(model: splitKey)
                                }
                            }
                        }
                        else {
                            Key(model: key)
                        }
                    }
                }
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
    }
}
