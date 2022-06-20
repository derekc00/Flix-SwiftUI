//
//  MovieRow.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import SwiftUI
import Kingfisher

struct MovieRow: View {
  @State var isPresented: Bool = false
  @State var movie: Movie
  var body: some View {
    Button {
      isPresented.toggle()
      MovieData.getMovieDetails(bearerToken: MovieData.bearerToken, movieId: movie.id) { updatedMovie in
        movie = updatedMovie
      }
    } label: {
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
          .frame(maxWidth: 150)
      }
    }
    .buttonStyle(.plain)
    .sheet(isPresented: $isPresented) {
      print("\(isPresented)")
    } content: {
      MovieDetails(movie: $movie)
    }

  }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
      MovieRow(movie: MovieData.generateTestMovie())
    }
}
