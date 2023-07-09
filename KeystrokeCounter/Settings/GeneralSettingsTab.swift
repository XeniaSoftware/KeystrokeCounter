//
//  GeneralTab.swift
//  KeystrokeCounter
//
//  Created by William Staggs on 11/12/22.
//

import SwiftUI

struct GeneralSettingsTab: View {
    @EnvironmentObject var appController: AppController
    @State private var window: NSWindow?
    @Environment(\.openURL) var openURL

    var body: some View {
        if appController.appModel != nil {
            VStack {
                Toggle("Hide dock icon", isOn: $appController.appModel.hideAppIcon)
                Toggle("Hide menu bar icon", isOn: $appController.appModel.hideMenuBar)
                ColorPicker(selection: $appController.appModel.color, supportsOpacity: false) {
                    Text("Key color: ")
                }
                Toggle("Use short number in menu bar", isOn: $appController.appModel.useShortMenuString)
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
            .frame(width: 350, height: 250)
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
            .onChange(of: appController.appModel.useShortMenuString, perform: { _ in
                appController.save()
                appController.updateMenuBar()
            })
            .onChange(of: window, perform: { window in
                if let settings = window {
                    appController.addWindow(for: .Settings, reference: settings)
                }
            })
            .onChange(of: appController.appModel.hideAppIcon, perform: { _ in
                appController.setApplicationPresentationMode()
                appController.save()
            })
            .onChange(of: appController.appModel.hideMenuBar, perform: { _ in
                appController.setMenuBarVisibility()
                appController.save()
            })
            .window($window)
        }
    }
}

struct GeneralTab_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsTab()
    }
}
