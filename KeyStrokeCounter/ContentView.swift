//
//  ContentView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var collection: KeyStrokeCollectionModel
    @State var error: String? = nil
    
    func register() {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options)

        if !accessEnabled {
            error = "Access Not Enabled"
        }

        NSEvent.addGlobalMonitorForEvents(
            matching: .keyDown,
            handler: collection.handle
        )
    }
    
    var body: some View {
        VStack {
            Text("Total: " + String(collection.total))
                .font(.largeTitle)
            Keyboard(layout: KeyboardLayout(definition: Qwerty))
                .padding([.bottom, .leading, .trailing])
        }
        .padding(.all)
        .onAppear(perform: register)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(KeyStrokeCollectionModel(shouldLoad: false))
    }
}
