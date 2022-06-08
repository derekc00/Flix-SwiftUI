//
//  MovieImageCarousel.swift
//  Flix
//
//  Created by Derek Chang on 6/7/22.
//

import SwiftUI
import struct Kingfisher.KFImage
import struct Kingfisher.AnyModifier

struct MovieImageCarousel: View {
  @State var imageIdx = 0
  var movie: Movie
  var body: some View {
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
  }
}

struct MovieImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
      MovieImageCarousel(movie: MovieData.generateTestMovie())
    }
}
