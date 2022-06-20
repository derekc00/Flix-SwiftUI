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
  @Binding var movie: Movie
  @State private var imageIdx = 0
  let inset = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
  var body: some View {
      ScrollView {
        VStack(alignment: .leading, spacing: 0) {
          MovieImageCarousel(movie: $movie)
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
}

struct MovieDetails_Previews: PreviewProvider {
  @State static var movie: Movie = MovieData.generateTestMovie()
    static var previews: some View {
      MovieDetails(movie: $movie)
    }
}
