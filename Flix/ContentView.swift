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
    TabView {
      List(movieData.movies) { movie in
        MovieRow(movie: movie)
      }
      .onAppear {
        if movieData.movies.count == 0 {
          movieData.refreshNowPlaying()
        }
      }
      .tabItem({
        VStack {
          Image("ticket_tabbar_icon")
            .padding()
          Text("Now Playing")
        }
      })
      .tag(0)
      ScrollView {
        LazyVGrid(columns: Array(repeating: .init(.adaptive(minimum: 120)), count: 2)) {
          ForEach(movieData.movies) { movie in
            PosterView(posterUrl: movie.posterUrl)
          }
        }.padding(.horizontal)
      }
      .tabItem({
        VStack {
          Image("superhero_tabbar_item")
            .padding()
          Text("Superheros")
        }
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let movieData = MovieData()
    ContentView(movieData: movieData)
      .onAppear {
        movieData.loadJson()
      }
  }
}
