//
//  LoadingView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
            .font(.largeTitle)
            .frame(width: 900, height: 435)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
