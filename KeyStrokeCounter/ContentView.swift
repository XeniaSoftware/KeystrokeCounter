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
    
    var body: some View {
        VStack {
            if error != nil {
                Text(error!)
            }
            Text(String(collection.total))
        }
        .frame(width: 50)
        .padding()
        .onAppear(perform: { () in
            let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String : true]
            let accessEnabled = AXIsProcessTrustedWithOptions(options)

            if !accessEnabled {
                error = "Access Not Enabled"
            }

            NSEvent.addGlobalMonitorForEvents(
                matching: .keyDown,
                handler: collection.handle
            )
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(KeyStrokeCollectionModel())
    }
}
