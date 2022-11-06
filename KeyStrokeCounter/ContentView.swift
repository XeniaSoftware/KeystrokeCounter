//
//  ContentView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var appController: AppController
    @State var error: String? = nil
    
    func register() {
        var foundFloating = false
        for window in NSApplication.shared.windows {
            if window.title == "Floating" {
                foundFloating = true
            }
            if window.title == "Keyboard" {
                window.level = .normal
                window.standardWindowButton(.zoomButton)?.isHidden = true
                window.standardWindowButton(.closeButton)?.isHidden = false
                window.standardWindowButton(.miniaturizeButton)?.isHidden = false
            }
        }
        
        if foundFloating == false {
            if let url = URL(string: "keystroke://viewer") {
                 openURL(url)
            }
        }

        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)

        if !accessEnabled {
            error = "Access Not Enabled"
        }

        NSEvent.addGlobalMonitorForEvents(
            matching: .keyDown,
            handler: appController.handle
        )
    }
    
    var body: some View {
        VStack {
            Text("Total: " + String(appController.appModel.total))
                .font(.largeTitle)
            HStack {
                ColorPicker(selection: $appController.appModel.color, supportsOpacity: false) { EmptyView() }
                Spacer()
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
        .frame(width: 820, height: 405)
        .padding(.all)
        .onAppear(perform: register)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppController(appModel: AppModel()))
    }
}
