//
//  MovieCollectionView.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 06.08.22.
//

import SwiftUI

struct MovieCollectionView: View {

    @State var cells: [Movie]

    private var columns: [GridItem] = {
        [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    }()

    init(cells: [Movie]) {
        self.cells = cells
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(cells) { cell in
                    MovieCell(imageName: cell.imgName,
                              title: cell.title,
                              genre: cell.genre,
                              releaseDate: cell.releaseDate)
                    .background(.white)
                }
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
        }
        .background(.gray)
    }
}

struct MovieCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCollectionView(cells: Movie.mockData(rows: 10))
    }
}
