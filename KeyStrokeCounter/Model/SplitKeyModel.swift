//
//  SplitKeyModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/2/22.
//

import Foundation

struct SplitKeyModel: KeyProtocol {
    public let keys: [KeyModel]
    public var id: String {
        return keys.reduce("", { (prev, current) in
            return prev.appending(current.id)
        })
    }
    
}
