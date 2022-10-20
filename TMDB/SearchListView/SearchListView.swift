//
//  SearchListView.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 07.08.22.
//

import SwiftUI

struct SearchListView: View {

    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            MovieCollectionView(cells: Movie.mockData(rows: 5))
            .navigationTitle("TMDB")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
