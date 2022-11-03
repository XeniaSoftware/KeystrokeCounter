//
//  Key.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Key: View {
    private let baseSize: CGFloat = 50
    
    public let layout: KeyboardLayout
    public let model: KeyModel
    public var percentile: Int
    
    @EnvironmentObject var collection: KeyStrokeCollectionModel
    @State private var hovered: Bool = false
    
    func color() -> Color {
        var color = Color(.white)
        let opacity = (Double(percentile) / 100)
        color = Color(red: 1, green: 0, blue: 0, opacity: opacity)
        return color
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color())
                .frame(width: model.scale * baseSize, height: model.heightScale * baseSize)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                        .foregroundColor(color())
                }
            VStack {
                if hovered {
                    Text(String(percentile))
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
        Key(layout: KeyboardLayout(definition: Qwerty), model: KeyModel(middleLabel: "esc"), percentile: 50)
    }
}
