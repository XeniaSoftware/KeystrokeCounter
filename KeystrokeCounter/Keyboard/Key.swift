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

    @Binding var showLabels: Bool    
    @EnvironmentObject var appController: AppController
    @State private var hovered: Bool = false
    
    func color() -> Color {
        let percentile = appController.appModel.getPercentile(key: model)
        return appController.appModel.color.opacity(Double(percentile) / 100)
    }
    
    func getLabel(for keyLabel: KeyLabel) -> String {
        let label = model.getLabel(for: keyLabel)
        
        if hovered || showLabels, label != "" {
            return String(appController.appModel.getCount(for: label))
        }
        return label
    }
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: appController.appModel.keyCornerRadius)
                    .fill(background)
                RoundedRectangle(cornerRadius: appController.appModel.keyCornerRadius)
                    .fill(color())
                RoundedRectangle(cornerRadius: appController.appModel.keyCornerRadius)
                    .strokeBorder(background)
            }
            .frame(width: model.scale * baseSize, height: model.heightScale * baseSize)
            VStack {
                Spacer()
                Text(getLabel(for:.top))
                    .foregroundColor(.black)
                Text(getLabel(for:.middle))
                    .foregroundColor(.black)
                Text(getLabel(for:.bottom))
                    .foregroundColor(.black)
                Spacer()
            }
            .frame(width: model.scale * baseSize, height: model.heightScale * baseSize)
        }
        .onHover { hovered in
            self.hovered = hovered
        }
    }
}

