//
//  Key.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/1/22.
//

import SwiftUI

struct Key: View {
    @EnvironmentObject var collection: KeyStrokeCollectionModel

    private let baseSize: CGFloat = 50
    
    public let label: String
    public let topLabel: String
    public let bottomLabel: String
    public let width: CGFloat
    public let height: CGFloat
    
    @State private var hovered: Bool = false
    
    init(label: String = "", topLabel: String = "", bottomLabel: String = "", scale: CGFloat = 1, heightScale: CGFloat = 1) {
        self.label = label
        self.topLabel = topLabel
        self.bottomLabel = bottomLabel
        self.width = baseSize * scale
        self.height = baseSize * heightScale
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                }
            VStack {
                if hovered {
                    Text(String(collection.getCount(chars: [self.topLabel, self.bottomLabel, self.label])))
                        .foregroundColor(.black)
                } else {
                    Spacer()
                    Text(topLabel)
                        .foregroundColor(.black)
                    Text(label)
                        .foregroundColor(.black)
                    Text(bottomLabel)
                        .foregroundColor(.black)
                    Spacer()
                }
                
            }
            .frame(width: width, height: height)
        }
        .onHover { hovered in
            self.hovered = hovered
        }
    }
}

struct Key_Previews: PreviewProvider {
    static var previews: some View {
        Key(topLabel: "`", bottomLabel: "~")
    }
}
