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
            Text("Total: " + String(collection.total))
                .font(.largeTitle)
            Spacer()
            HStack {
                VStack {
                    ForEach(Array(collection.getModel().chars.keys).sorted(), id: \.self) { char in
                        HStack {
                            Text(char)
                            Text(String(collection.getModel().chars[char]!))
                        }
                    }
                }
                Spacer()
                VStack {
                    ForEach(Array(collection.getModel().numbers.keys).sorted(), id: \.self) { number in
                        HStack {
                            Text(number)
                            Text(String(collection.getModel().numbers[number]!))
                        }
                    }
                }
                Spacer()
                VStack {
                    ForEach(Array(collection.getModel().symbols.keys).sorted(), id: \.self) { symbol in
                        HStack {
                            Text(symbol)
                            Text(String(collection.getModel().symbols[symbol]!))
                        }
                    }
                }
                Spacer()
                VStack {
                    ForEach(Array(collection.getModel().modifiers.keys).sorted(), id: \.self) { modifier in
                        HStack {
                            Text(modifier)
                            Text(String(collection.getModel().modifiers[modifier]!))
                        }
                    }
                }
            }
        }
        .frame(width: 500, height: 700)
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
            .environmentObject(KeyStrokeCollectionModel(shouldLoad: false))
    }
}
