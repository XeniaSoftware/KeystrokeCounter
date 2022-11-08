//
//  MainView.swift
//  KeyStrokeCounter
//
//  Created by William Staggs on 11/5/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var appController: AppController

    var body: some View {
        if appController.appModel == nil {
            LoadingView()
        } else {
            ContentView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
