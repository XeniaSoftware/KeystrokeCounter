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
    public let background = Color(red: 0.22, green: 0.22, blue: 0.22)
    public let cornerRadius: CGFloat = 10
    
    @EnvironmentObject var appController: AppController
    @State private var hovered: Bool = false
    
    func color() -> Color {
        let percentile = appController.appModel.getPercentile(key: model)
        return appController.appModel.color.opacity(Double(percentile) / 100)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(background)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(color())
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(background)
            }
            .frame(width: model.scale * baseSize, height: model.heightScale * baseSize)
            VStack {
                if hovered {
                    Text(String(appController.appModel.getCount(for: model)))
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
