//
//  Count.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import SwiftUI

struct CountMenu: View {
    @StateObject var appController = AppController.shared
    
    var total: Int {
        return appController.appModel?.total ?? 0
    }
    
    var body: some View {
        HStack {
            Text("Keycount: " + String(total))
                .foregroundColor(.secondary)
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
