//
//  SettingsView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appController: AppController

    var body: some View {
        VStack {
            TabView {
                GeneralSettingsTab().tabItem{ Label("General", systemImage: "gearshape") }
                KeyboardSettingsTab().tabItem { Label("Keyboard", systemImage: "keyboard") }
            }
        }.padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
