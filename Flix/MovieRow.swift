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
  var movie: Movie
  var body: some View {
    Button {
      isPresented.toggle()
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
      }
    }
    .buttonStyle(.plain)
    .sheet(isPresented: $isPresented) {
      print("\(isPresented)")
    } content: {
      MovieDetails(movie: movie)
    }

  }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
      MovieRow(movie: MovieData.generateTestMovie())
    }
}
