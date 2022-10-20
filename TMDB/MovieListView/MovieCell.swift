//
//  MovieCell.swift
//  TMDB
//
//  Created by Matheus Cardoso Kuhn on 06.08.22.
//

import SwiftUI

struct MovieCell: View {
    // MARK: - Variables
    let imageName: String
    let title: String
    let genre: String
    let releaseDate: String

    // MARK: - Content
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .border(.black, width: 2)
                .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
            Text(title)
                .font(.title2)
                .foregroundColor(.black)
                .fontWeight(.semibold)
            Text(genre)
                .font(.subheadline)
                .foregroundColor(.black)
                .fontWeight(.medium)
            Text(releaseDate)
                .font(.body)
                .foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 8,
                            leading: 0,
                            bottom: 8,
                            trailing: 0))
    }
}

struct MovieCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(imageName: "placeholder_movie",
                  title: "Título do filme - o retorno",
                  genre: "Ação",
                  releaseDate: "06/08/2022")
            .previewLayout(.fixed(width: 250, height: 400))
    }
}
