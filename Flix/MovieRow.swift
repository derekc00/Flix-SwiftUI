//
//  MovieRow.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import SwiftUI
import Kingfisher

struct MovieRow: View {
  var movie: Movie
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(movie.title)
          .font(.title3)
          .bold()
          .padding(.bottom)
        Text(movie.overview)
          .font(.body)
          .lineLimit(4)
      }
      Spacer()
      PosterView(posterUrl: movie.posterUrl)
    }
  }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
      MovieRow(movie: MovieData.generateTestMovie())
    }
}
