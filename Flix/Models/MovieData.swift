//
//  MovieData.swift
//  Flix
//
//  Created by Derek Chang on 6/2/22.
//

import Foundation

class MovieData: ObservableObject {
  @Published var movies: [Movie] = []
  static let bearerToken = """
        eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NzBhYjBmMTAwNDBjY\
    mMxMmM2MGM4YmIxZTMxOGZhZSIsInN1YiI6IjYyOTg4MjNhZWMwYzU4MDA1MDY2M\
    2IwOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MC-wYKP3\
    3QEpNhm7S43QarfKOvWkhBB_p6nmWermdIc
    """
  static let apiKey = "870ab0f10040cbc12c60c8bb1e318fae"
  init () {
    getNowPlayingMovies(bearerToken: MovieData.bearerToken, completion: { nowPlayingMovies in
      self.movies = nowPlayingMovies
    })
  }
  func refreshNowPlaying() {
    getNowPlayingMovies(bearerToken: MovieData.bearerToken, completion: { nowPlayingMovies in
      self.movies = nowPlayingMovies
    })
  }
  func loadJson () {
    var movies: [Movie] = []
      if let url = Bundle.main.url(forResource: "NowPlayingMoviesTestData", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            guard let dataDictionary =
                   try JSONSerialization.jsonObject(with: data, options: [])
                   as? [String: Any]
            else {
              fatalError()
            }
            for case let result in dataDictionary["results"]
                 as? [[String: Any]] ?? [[:]] {
              if let movie = try? Movie(json: result) {
                movies.append(movie)
              }
            }
        } catch {
            print("error:\(error)")
        }
      }
    self.movies = movies
  }
  /// This function gets movies that are currently playing in theaters.
  /// Attaches bearer token to url request for authentication.
  ///
  /// - Parameter bearerToken: Type ``String``. Found on TMDB API docs.
  /// - Parameter completion: returns list [``Movie``] that are currently playing
  /// - Returns: Void
  func getNowPlayingMovies(bearerToken: String, completion: @escaping ([Movie]) -> Void) {
    let nowPlayingUrl =
      URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
    var nowPlayingRequest = URLRequest(url: nowPlayingUrl)
    nowPlayingRequest.setValue("Bearer <<access-token>>",
                              forHTTPHeaderField: "Authentication")
    nowPlayingRequest.setValue("application/json;charset=utf-8",
                               forHTTPHeaderField: "Content-Type")
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.httpAdditionalHeaders =
      ["Authorization": "Bearer \(bearerToken)"]
    let session = URLSession(configuration: sessionConfiguration)

    session.dataTask(with: nowPlayingRequest) { (data, _, error) in
      var movies: [Movie] = []
      if let error = error {
          print(error.localizedDescription)
      } else if let data = data {
         do {
           guard let dataDictionary =
                  try JSONSerialization.jsonObject(with: data, options: [])
                  as? [String: Any]
           else {
             fatalError()
           }
           for case let result in dataDictionary["results"]
                as? [[String: Any]] ?? [[:]] {
             if let movie = try? Movie(json: result) {
               movies.append(movie)
             }
           }
           completion(movies)
         } catch {
           print(error)
         }
       }
    }.resume()
  }
  static func getMovieDetails(bearerToken: String, movieId: Int, completion: @escaping (Movie) -> Void) {
    let movieUrl =
      URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?append_to_response=videos,images")!
    var movieDetailRequest = URLRequest(url: movieUrl)
    movieDetailRequest.setValue("Bearer <<access-token>>",
                              forHTTPHeaderField: "Authentication")
    movieDetailRequest.setValue("application/json;charset=utf-8",
                               forHTTPHeaderField: "Content-Type")
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.httpAdditionalHeaders =
      ["Authorization": "Bearer \(bearerToken)"]
    let session = URLSession(configuration: sessionConfiguration)

    session.dataTask(with: movieDetailRequest) { (data, _, error) in
      var movie: Movie
      if let error = error {
          print(error.localizedDescription)
      } else if let data = data {
         do {
           guard let dataDictionary =
                  try JSONSerialization.jsonObject(with: data, options: [])
                  as? [String: Any]
           else {
             fatalError()
           }
           movie = try Movie(json: dataDictionary)
           completion(movie)
         } catch {
           print(error)
         }
       }
    }.resume()
  }
  static func generateTestMovies() -> [Movie] {
    var movies: [Movie] = []
    for idx in 1...10 {
      movies.append(
        Movie(title: "Movie \(idx)",
              id: idx,
              overview: "overview sample",
              popularity: .random(in: 1...100).rounded(),
              status: .inProduction,
              backdropUrl: "",
              posterUrl: "",
              additionalImages: []
              )
      )
    }
    return movies
  }
  static func generateTestMovie() -> Movie {
    let movieData = MovieData.generateTestMovies()
    return movieData[0]
  }
}
