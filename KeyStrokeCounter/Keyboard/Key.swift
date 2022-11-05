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
    
    @EnvironmentObject var appController: AppController
    @State private var hovered: Bool = false
    
    func color() -> Color {
        let percentile = appController.appModel.getPercentile(key: model)
        return appController.appModel.color.opacity(Double(percentile) / 100)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.black, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 10).fill(color()))
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
