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
  @Binding var movie: Movie
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView {
        ForEach(Array(zip(movie.getAllImageUrls().indices, movie.getAllImageUrls())), id: \.0) { idx, image in
          KFImage(URL(string: image))
            .requestModifier(Kingfisher.AnyModifier.authModifier)
            .resizable()
            .onAppear {
              imageIdx = idx
            }
        }
      }
      .aspectRatio(1.779, contentMode: .fit)
      .tabViewStyle(.page(indexDisplayMode: .never))
      CarouselCircles(numCircles: 3, selected: $imageIdx)
        .frame(width: 150, height: 25)
    }
  }
}

struct MovieImageCarousel_Previews: PreviewProvider {
  @State static var movie: Movie = MovieData.generateTestMovie()
  static var previews: some View {
    MovieImageCarousel(movie: $movie)
  }
}
