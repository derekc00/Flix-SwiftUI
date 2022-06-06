//
//  ContentView.swift
//  Flix
//
//  Created by Derek Chang on 6/2/22.
//

import SwiftUI

struct ContentView: View {
//  @State private var nowPlayingMovies = "initial"
  var movieData = MovieData()
  var body: some View {
    NavigationView {
      List(movieData.movies) { movie in
        ZStack {
          NavigationLink {
            MovieDetails(movie: movie)
          } label: {
            EmptyView()
          }
          .buttonStyle(.plain)
          .opacity(0.0)
          MovieRow(movie: movie)
        }

      }
      .navigationTitle("Now Playing")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
