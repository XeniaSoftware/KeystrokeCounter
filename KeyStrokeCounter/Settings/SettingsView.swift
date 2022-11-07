//
//  SettingsView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/6/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appController: AppController
    @Environment(\.openURL) var openURL
    @State private var window: NSWindow?

    var body: some View {
        if appController.appModel != nil {
            VStack {
                ColorPicker(selection: $appController.appModel.color, supportsOpacity: false) {
                    Text("Key color: ")
                }
                Toggle("Show floating window", isOn: $appController.appModel.showFloatingWindow)
                Picker("Floating window position", selection: $appController.appModel.floatingWindowPosition) {
                    ForEach(Position.allCases, id: \.rawValue) { position in
                        Text(position.rawValue).tag(position)
                    }
                }
                Slider(
                    value: $appController.appModel.opacity,
                    in: 0...1,
                    step: 0.05
                ) {
                    Text("Opacity")
                } minimumValueLabel: {
                    Text("0%")
                } maximumValueLabel: {
                    Text("100%")
                }
            }
            .padding(.all)
            .frame(width: 350, height: 150)
            .onChange(of: appController.appModel.showFloatingWindow) { showFloatingValue in
                if showFloatingValue == true {
                    if let url = URL(string: "keystroke://" + Windows.Floating.rawValue) {
                         openURL(url)
                    }
                }
            }
            .onChange(of: appController.appModel.color) { _ in
                appController.save()
            }
            .onChange(of: appController.appModel.showFloatingWindow) { _ in
                appController.save()
            }
            .onChange(of: appController.appModel.floatingWindowPosition) { _ in
                appController.save()
            }
            .onChange(of: window, perform: { window in
                if let settings = window {
                    appController.addWindow(for: .Settings, reference: settings)
                }
            })
            .window($window)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
