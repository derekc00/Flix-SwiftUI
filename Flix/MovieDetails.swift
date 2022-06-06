//
//  MovieDetails.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import SwiftUI
import struct Kingfisher.KFImage
import struct Kingfisher.AnyModifier

struct CardView: View {
    var body: some View {
        Rectangle()
            .fill(Color.pink)
            .frame(height: 200)
            .border(Color.black)
            .padding()
    }
}
struct MovieDetails: View {
  @State var movie: Movie
  @State private var imageIdx = 0
  let inset = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
  var body: some View {
    GeometryReader { proxy in
      ScrollView {
        VStack(alignment: .leading) {
          TabView(selection: $imageIdx, content: {
            Group {
              KFImage(URL(string: movie.backdropUrl))
                .requestModifier(Kingfisher.AnyModifier.authModifier)
                .resizable()
                //            .aspectRatio(0.67, contentMode: .fit)
                .cornerRadius(8)
              ForEach(movie.additionalImages) { image in
                KFImage(URL(string: image.url))
                  .requestModifier(Kingfisher.AnyModifier.authModifier)
                  .resizable()
                  .cornerRadius(8)
              }
            }
          })
          .frame(width: proxy.size.width,
                 height: proxy.size.height / 2.5)
          .tabViewStyle(.page(indexDisplayMode: .never))
          HStack {
            Text(movie.title)
              .font(.largeTitle)
              .bold()
              .padding(inset)
            Spacer()
            Text(String.init(describing: movie.popularity.rounded()))
              .padding(inset)
          }
          Text(movie.overview)
            .padding(inset)
          Spacer()
        }
      }
    }
    .onAppear {
      MovieData.getMovieDetails(bearerToken: MovieData.bearerToken, movieId: movie.id) { updatedMovie in
        movie = updatedMovie
        print(movie.additionalImages)
      }
    }
  }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
      MovieDetails(movie: MovieData.generateTestMovie())
    }
}
