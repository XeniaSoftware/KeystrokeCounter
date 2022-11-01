//
//  KeyStrokeCollectionModel.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 10/31/22.
//

import Foundation
import AppKit

class KeyStrokeCollectionModel: ObservableObject {
    @Published var keystrokeCollection: Dictionary<String, KeyStrokeModel> = [:]
    
    var total: Int {
        print("Getting Total")
        return getModel().total
    }
    
    func todayAsString() -> String {
        let today = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter .dateStyle = DateFormatter.Style.short

        return dateFormatter.string(from: today)
    }
    
    func getModel() -> KeyStrokeModel {
        let todayString = todayAsString()
        print(todayString)
        let model = keystrokeCollection[todayString] ?? KeyStrokeModel()
        
        if keystrokeCollection[todayString] == nil {
            keystrokeCollection[todayString] = model
        }
        
        print(model.keystrokes.debugDescription)
        print(model.total)
        return model
    }
    
    func handle(event: NSEvent) {
        let model = getModel()
        model.handle(event: event)
        objectWillChange.send()
    }
}
