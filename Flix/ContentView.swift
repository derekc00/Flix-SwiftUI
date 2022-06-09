//
//  ContentView.swift
//  Flix
//
//  Created by Derek Chang on 6/2/22.
//

import SwiftUI

struct ContentView: View {
  var movieData = MovieData()
  var body: some View {
    List(movieData.movies) { movie in
      MovieRow(movie: movie)
    }
    .onAppear {
      if movieData.movies.count == 0 {
        movieData.refreshNowPlaying()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
