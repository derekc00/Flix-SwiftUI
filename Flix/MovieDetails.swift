//
//  MovieDetails.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import SwiftUI
import struct Kingfisher.KFImage
import struct Kingfisher.AnyModifier

struct MovieDetails: View {
  @State var movie: Movie
  @State private var imageIdx = 0
  let inset = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
  var body: some View {
    GeometryReader { proxy in
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          TabView(selection: $imageIdx, content: {
            KFImage(URL(string: movie.backdropUrl))
              .requestModifier(Kingfisher.AnyModifier.authModifier)
              .resizable()
            ForEach(movie.additionalImages) { image in
              KFImage(URL(string: image.url))
                .requestModifier(Kingfisher.AnyModifier.authModifier)
                .resizable()
            }
          })
          .aspectRatio(1.779, contentMode: .fit)
          .tabViewStyle(.page(indexDisplayMode: .never))
          HStack {
            Text(movie.title)
              .font(.largeTitle)
              .bold()
              .padding(inset)
            Spacer()
            RatingView(rating: movie.popularity)
              .frame(width: 100, height: 100)
          }
          Text(movie.overview)
            .padding(inset)
        }
      }
    }
    .onAppear {
      MovieData.getMovieDetails(bearerToken: MovieData.bearerToken, movieId: movie.id) { updatedMovie in
        movie = updatedMovie
      }
    }
  }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
      MovieDetails(movie: MovieData.generateTestMovie())
    }
}
