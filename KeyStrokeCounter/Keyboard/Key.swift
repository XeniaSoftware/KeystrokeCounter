//
//  Key.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Key: View {
    private let baseSize: CGFloat = 50
    
    public let model: KeyModel
    
    @State private var hovered: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: model.scale * baseSize, height: model.heightScale * baseSize)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                }
            VStack {
                if hovered {
                    Text(String(model.keyCount))
                        .foregroundColor(.black)
                } else {
                    Spacer()
                    Text(model.topLabel)
                        .foregroundColor(.black)
                    Text(model.middleLabel)
                        .foregroundColor(.black)
                    Text(model.bottomLabel)
                        .foregroundColor(.black)
                    Spacer()
                }
                
            }
            .frame(width: model.scale * baseSize, height: model.heightScale * baseSize)
        }
        .onHover { hovered in
            self.hovered = hovered
        }
    }
}

struct Key_Previews: PreviewProvider {
    static var previews: some View {
        Key(model: KeyModel(middleLabel: "esc"))
    }
}
