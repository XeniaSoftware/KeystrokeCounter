//
//  Count.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import SwiftUI

struct CountMenu: View {
    var body: some View {
        HStack {
            Text("Keycount: 30000")
            Spacer()
        }
        .padding(.leading)
    }
}

struct Count_Previews: PreviewProvider {
    static var previews: some View {
        CountMenu()
    }
}
