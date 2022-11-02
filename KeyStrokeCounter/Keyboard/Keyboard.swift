//
//  Keyboard.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Keyboard: View {
    @EnvironmentObject var collection: KeyStrokeCollectionModel

    var body: some View {
        VStack {
            HStack {
                Group {
                    Key(label: "esc", scale: 1.5)
                    Key(label: "F1")
                    Key(label: "F2")
                    Key(label: "F3")
                    Key(label: "F4")
                    Key(label: "F5")
                    Key(label: "F6")
                    Key(label: "F7")
                    Key(label: "F8")
                    Key(label: "F9")
                }
                Group {
                    Key(label: "F10")
                    Key(label: "F11")
                    Key(label: "F12")
                    Key(label: "")
                }
            }
            HStack {
                Group {
                    Key(topLabel: "~", bottomLabel: "`")
                    Key(topLabel: "!", bottomLabel: "1")
                    Key(topLabel: "@", bottomLabel: "2")
                    Key(topLabel: "#", bottomLabel: "3")
                    Key(topLabel: "$", bottomLabel: "4")
                    Key(topLabel: "%", bottomLabel: "5")
                    Key(topLabel: "^", bottomLabel: "6")
                    Key(topLabel: "&", bottomLabel: "7")
                    Key(topLabel: "*", bottomLabel: "8")
                    Key(topLabel: "(", bottomLabel: "9")
                }
                Group {
                    Key(topLabel: ")", bottomLabel: "0")
                    Key(topLabel: "_", bottomLabel: "-")
                    Key(topLabel: "+", bottomLabel: "=")
                    Key(label: "delete", scale: 1.5)
                }
            }
            HStack {
                Group {
                    Key(label: "tab", scale: 1.5)
                    Key(label: "Q")
                    Key(label: "W")
                    Key(label: "E")
                    Key(label: "R")
                    Key(label: "T")
                    Key(label: "Y")
                    Key(label: "U")
                    Key(label: "I")
                    Key(label: "O")
                }
                Group {
                    Key(label: "P")
                    Key(topLabel: "{", bottomLabel: "[")
                    Key(topLabel: "}", bottomLabel: "]")
                    Key(topLabel: "|", bottomLabel: "\\")
                }
            }
            HStack {
                Group {
                    Key(label: "caps lock", scale: 1.8)
                    Key(label: "A")
                    Key(label: "S")
                    Key(label: "D")
                    Key(label: "F")
                    Key(label: "G")
                    Key(label: "H")
                    Key(label: "J")
                    Key(label: "K")
                    Key(label: "L")
                }
                Group {
                    Key(topLabel: "{", bottomLabel: ";")
                    Key(topLabel: "{", bottomLabel: "'")
                    Key(label: "return", scale: 1.8)
                }
            }
            HStack {
                Group {
                    Key(label: "shift", scale: 2.4)
                    Key(label: "Z")
                    Key(label: "X")
                    Key(label: "C")
                    Key(label: "V")
                    Key(label: "B")
                    Key(label: "N")
                    Key(label: "M")
                    Key(topLabel: "<", bottomLabel: ",")
                    Key(topLabel: ">", bottomLabel: ".")
                }
                Group {
                    Key(topLabel: "?", bottomLabel: "/")
                    Key(label: "shift", scale: 2.4)
                }
            }
            HStack {
                Group {
                    Key(label: "fn")
                    Key(label: "control")
                    Key(label: "⌥")
                    Key(label: "⌘", scale: 1.2)
                    Key(label: "space", scale: 5.8)
                    Key(label: "⌘", scale: 1.2)
                    Key(label: "⌥")
                    Key(label: "←")
                    VStack(spacing: 0) {
                        Key(label: "↑", heightScale: 0.5)
                        Key(label: "↓", heightScale: 0.5)
                    }
                    Key(label: "→")
                }
            }
        }

    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
    }
}
