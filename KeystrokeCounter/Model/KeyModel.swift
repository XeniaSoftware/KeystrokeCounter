//
//  File.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/2/22.
//

import Foundation

enum KeyLabel: Codable {
    case top, middle, bottom
}

struct KeyModel: Identifiable, Hashable, Codable {

    public let labels: Dictionary<KeyLabel, String>
    public let scale: CGFloat
    public let heightScale: CGFloat
    public var isSplit: Bool = false
    public var splitKeys: [KeyModel] = []
    
    public var id: String {
        return getLabel(for: .top) + getLabel(for: .middle) + getLabel(for: .bottom)
    }
    
    func getLabel(for keylabel: KeyLabel) -> String {
        return labels[keylabel] ?? ""
    }
    
    init(topLabel: String, bottomLabel: String, scale: CGFloat = 1) {
        self.labels = [
            .top: topLabel,
            .bottom: bottomLabel
        ]
        self.scale = scale
        self.heightScale = 1
    }
    
    init(middleLabel: String, scale: CGFloat = 1) {
        self.labels = [
            .middle: middleLabel
        ]
        self.scale = scale
        self.heightScale = 1
    }
    
    init(middleLabel: String, heightScale: CGFloat) {
        self.labels = [
            .middle: middleLabel
        ]
        self.heightScale = heightScale
        self.scale = 1
    }
    
    init(splitKeys: [KeyModel]) {
        self.labels = [:]
        self.splitKeys = splitKeys
        self.isSplit = true
        self.scale = 1
        self.heightScale = 1
    }
}
