//
//  TMDBApp.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 06.08.22.
//

import SwiftUI

@main
struct TMDBApp: App {

    init() {
        UINavigationBar.appearance().isTranslucent = false
        UITabBar.appearance().isTranslucent = false
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
