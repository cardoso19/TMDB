//
//  MainView.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 06.08.22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MovieListView()
            .tabItem {
                Label("Home", systemImage: "house")
            }
            SearchListView()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
