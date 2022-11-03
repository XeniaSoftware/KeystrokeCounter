//
//  Keyboard.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Keyboard: View {
    @State var layout: KeyboardDefinition

    var body: some View {
        VStack {
            ForEach(layout, id: \.self) { row in
                HStack {
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
        Keyboard(layout: Qwerty)
    }
}
