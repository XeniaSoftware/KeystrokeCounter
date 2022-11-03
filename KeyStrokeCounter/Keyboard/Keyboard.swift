//
//  Keyboard.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var collection: KeyStrokeCollectionModel
    var layout: KeyboardLayout

    var body: some View {
        VStack {
            ForEach(layout.definition, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { key in
                        if key.isSplit {
                            VStack(spacing: 0) {
                                ForEach(key.splitKeys) { splitKey in
                                    Key(layout: layout, model: splitKey, percentile: layout.getPercentile(key: splitKey))
                                }
                            }
                        }
                        else {
                            Key(layout: layout, model: key, percentile: layout.getPercentile(key: key))
                        }
                    }
                }
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard(layout: KeyboardLayout(definition: Qwerty))
    }
}
