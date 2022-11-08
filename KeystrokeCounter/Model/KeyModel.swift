//
//  File.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/2/22.
//

import Foundation

struct KeyModel: Identifiable, Hashable, Codable {
    public let topLabel: String
    public let bottomLabel: String
    public let middleLabel: String
    public let scale: CGFloat
    public let heightScale: CGFloat
    public var isSplit: Bool = false
    public var splitKeys: [KeyModel] = []
    
    public var id: String {
        return topLabel + middleLabel + bottomLabel
    }
    
    init(topLabel: String, bottomLabel: String, scale: CGFloat = 1) {
        self.topLabel = topLabel
        self.bottomLabel = bottomLabel
        self.middleLabel = ""
        self.scale = scale
        self.heightScale = 1
    }
    
    init(middleLabel: String, scale: CGFloat = 1) {
        self.topLabel = ""
        self.bottomLabel = ""
        self.middleLabel = middleLabel
        self.scale = scale
        self.heightScale = 1
    }
    
    init(middleLabel: String, heightScale: CGFloat) {
        self.middleLabel = middleLabel
        self.heightScale = heightScale
        
        self.topLabel = ""
        self.bottomLabel = ""
        self.scale = 1
    }
    
    init(splitKeys: [KeyModel]) {
        self.splitKeys = splitKeys
        self.isSplit = true
        
        self.topLabel = ""
        self.middleLabel = ""
        self.bottomLabel = ""
        self.scale = 1
        self.heightScale = 1
    }
}
