//
//  KeyboardSettingsTab.swift
//  KeystrokeCounter
//
//  Created by William Staggs on 11/12/22.
//

import SwiftUI

struct KeyboardSettingsTab: View {
    @EnvironmentObject var appController: AppController

    var body: some View {
        if appController.appModel != nil {
            VStack {
                Slider(
                    value: $appController.appModel.keyCornerRadius,
                    in: 0...25,
                    step: 2
                ) {
                    Text("Corner Radius")
                } minimumValueLabel: {
                    Text("None")
                } maximumValueLabel: {
                    Text("Max")
                }
                Slider(
                    value: $appController.appModel.keySpacing,
                    in: 0...20,
                    step: 1
                ) {
                    Text("Key Spacing")
                } minimumValueLabel: {
                    Text("None")
                } maximumValueLabel: {
                    Text("Max")
                }
            }
        }
    }
}

struct KeyboardSettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardSettingsTab()
    }
}
