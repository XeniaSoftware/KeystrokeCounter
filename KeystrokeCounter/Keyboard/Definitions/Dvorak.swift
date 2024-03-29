//
//  Qwerty.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/2/22.
//

import Foundation

 
let Dvorak: KeyboardDefinition = [
    [
        KeyModel(middleLabel: "esc", scale: 1.5),
        KeyModel(middleLabel: "F1"),
        KeyModel(middleLabel: "F2"),
        KeyModel(middleLabel: "F3"),
        KeyModel(middleLabel: "F4"),
        KeyModel(middleLabel: "F5"),
        KeyModel(middleLabel: "F6"),
        KeyModel(middleLabel: "F7"),
        KeyModel(middleLabel: "F8"),
        KeyModel(middleLabel: "F9"),
        KeyModel(middleLabel: "F10"),
        KeyModel(middleLabel: "F11"),
        KeyModel(middleLabel: "F12"),
        KeyModel(middleLabel: "")
    ],
    [
        KeyModel(topLabel: "~", bottomLabel: "`"),
        KeyModel(topLabel: "!", bottomLabel: "1"),
        KeyModel(topLabel: "@", bottomLabel: "2"),
        KeyModel(topLabel: "#", bottomLabel: "3"),
        KeyModel(topLabel: "$", bottomLabel: "4"),
        KeyModel(topLabel: "%", bottomLabel: "5"),
        KeyModel(topLabel: "^", bottomLabel: "6"),
        KeyModel(topLabel: "&", bottomLabel: "7"),
        KeyModel(topLabel: "*", bottomLabel: "8"),
        KeyModel(topLabel: "(", bottomLabel: "9"),
        KeyModel(topLabel: ")", bottomLabel: "0"),
        KeyModel(topLabel: "{", bottomLabel: "["),
        KeyModel(topLabel: "}", bottomLabel: "]"),
        KeyModel(middleLabel: "delete", scale: 1.5)
    ],
    [
        KeyModel(middleLabel: "tab", scale: 1.5),
        KeyModel(topLabel: "\"", bottomLabel: "'"),
        KeyModel(topLabel: "<", bottomLabel: ","),
        KeyModel(topLabel: ">", bottomLabel: "."),
        KeyModel(middleLabel: "P"),
        KeyModel(middleLabel: "Y"),
        KeyModel(middleLabel: "F"),
        KeyModel(middleLabel: "G"),
        KeyModel(middleLabel: "C"),
        KeyModel(middleLabel: "R"),
        KeyModel(middleLabel: "L"),
        KeyModel(topLabel: "?", bottomLabel: "/"),
        KeyModel(topLabel: "+", bottomLabel: "="),
        KeyModel(topLabel: "|", bottomLabel: "\\")
    ],
    [
        KeyModel(middleLabel: "caps lock", scale: 1.8),
        KeyModel(middleLabel: "A"),
        KeyModel(middleLabel: "O"),
        KeyModel(middleLabel: "E"),
        KeyModel(middleLabel: "U"),
        KeyModel(middleLabel: "I"),
        KeyModel(middleLabel: "D"),
        KeyModel(middleLabel: "H"),
        KeyModel(middleLabel: "T"),
        KeyModel(middleLabel: "N"),
        KeyModel(middleLabel: "S"),
        KeyModel(topLabel: "_", bottomLabel: "-"),
        KeyModel(middleLabel: "return", scale: 1.8)
    ],
    [
        KeyModel(middleLabel: "shift", scale: 2.4),
        KeyModel(topLabel: ":", bottomLabel: ";"),
        KeyModel(middleLabel: "Q"),
        KeyModel(middleLabel: "J"),
        KeyModel(middleLabel: "K"),
        KeyModel(middleLabel: "X"),
        KeyModel(middleLabel: "B"),
        KeyModel(middleLabel: "M"),
        KeyModel(middleLabel: "W"),
        KeyModel(middleLabel: "V"),
        KeyModel(middleLabel: "Z"),
        KeyModel(middleLabel: "shift", scale: 2.4)
    ],
    [
        KeyModel(middleLabel: "fn"),
        KeyModel(middleLabel: "control"),
        KeyModel(middleLabel: "⌥"),
        KeyModel(middleLabel: "⌘", scale: 1.2),
        KeyModel(middleLabel: "space", scale: 5.8),
        KeyModel(middleLabel: "⌘", scale: 1.2),
        KeyModel(middleLabel: "⌥"),
        KeyModel(middleLabel: "←"),
        KeyModel(splitKeys: [
                KeyModel(middleLabel: "↑", heightScale: 0.5),
                KeyModel(middleLabel: "↓", heightScale: 0.5)
            ]
        ),
        KeyModel(middleLabel: "→")
    ]
]
