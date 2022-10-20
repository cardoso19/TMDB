//
//  MovieListView.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 07.08.22.
//

import SwiftUI

struct MovieListView: View {
    var body: some View {
        MovieCollectionView(cells: Movie.mockData(rows: 10))
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
