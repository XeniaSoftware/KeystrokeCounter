//
//  ContentView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appController: AppController
    @State var error: String? = nil
    
    func register() {
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
