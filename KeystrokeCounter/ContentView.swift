//
//  ContentView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.openURL) var openURL
    @EnvironmentObject var appController: AppController
    @State var error: String? = nil
    @State private var window: NSWindow?

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    appController.showSettings()
                } label: {
                    Image(systemName: "gear")
                }
            }
            Text("Total: " + String(appController.appModel.total))
                .font(.largeTitle)
            HStack {
                Picker("Layout", selection: $appController.appModel.keyboardDefinition) {
                    Text("Qwerty").tag(Qwerty)
                    Text("Dvorak").tag(Dvorak)
                    Text("Colemak").tag(Colemak)
                }
                .pickerStyle(.segmented)
                .frame(width: 150)
                .padding(.trailing)
            }
            Keyboard()
        }
        .frame(width: 820, height: 435)
        .padding(.all)
        .onChange(of: window, perform: { window in
            if let heatmap = window {
                appController.addWindow(for: .Heatmap, reference: heatmap)
                heatmap.level = .normal
                heatmap.standardWindowButton(.zoomButton)?.isHidden = true
                heatmap.standardWindowButton(.closeButton)?.isHidden = false
                heatmap.standardWindowButton(.miniaturizeButton)?.isHidden = false
                heatmap.isMovableByWindowBackground = true
            }
        })
        .window($window)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppController(appModel: AppModel()))
    }
}
