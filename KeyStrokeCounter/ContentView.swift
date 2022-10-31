//
//  ContentView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/30/22.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    @State var error: String? = nil
    
    var body: some View {
        VStack {
            if error != nil {
                Text(error!)
            }
            Text(String(self.count))
            HStack {
                Button("Reset") {
                    count = 0
                }
            }
        }
        .padding()
        .onAppear(perform: { () in
            let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
            let accessEnabled = AXIsProcessTrustedWithOptions(options)

            if !accessEnabled {
                error = "Access Not Enabled"
            }
            NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { (event) in
                guard let _ = event.characters else {
                    return
                }
                self.count += 1
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
