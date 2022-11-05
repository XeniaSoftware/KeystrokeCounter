//
//  Date.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import Foundation

extension Date {
    func simpleDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter .dateStyle = DateFormatter.Style.short

        return dateFormatter.string(from: self)
    }
}
