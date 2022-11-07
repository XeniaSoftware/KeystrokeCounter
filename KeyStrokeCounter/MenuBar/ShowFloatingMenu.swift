//
//  ShowFloatingMenu.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import SwiftUI

struct ShowFloatingMenu: View {
    @State var showFloating = true
    
    var body: some View {
//        CommandMenu("MyMenu") {
            Toggle(isOn: $showFloating, label: {
                Text("Show floating window")
            })
//        }
//        HStack {
//            
//        }
//        .padding(.leading, 5)
    }
}

struct ShowFloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        ShowFloatingMenu()
    }
}

struct MenuChecklistStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        // Return a view that has checklist appearance and behavior.
    }
}
