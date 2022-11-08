import SwiftUI

import AppKit

extension Color {
    var components: [CGFloat]? {
        return NSColor(self).cgColor.components
    }
}
