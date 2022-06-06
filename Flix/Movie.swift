//
//  Movie.swift
//  Flix
//
//  Created by Derek Chang on 6/2/22.
//

import Foundation

struct Movie: Codable, Identifiable {
  let title: String
  let id: Int
  let overview: String
  let popularity: Double
  let status: Status
  let backdropUrl: String
  let posterUrl: String
  var additionalImages: [MovieImage] = []
  var additionalVideos: [MovieVideo] = []
}

struct MovieImage: Codable, Identifiable {
  let id: Int
  let aspectRatio: Double
  let filePath: String
  let width: Int
  let url: String

  init(json: [String: Any]) throws {
   guard let aspectRatio = json["aspect_ratio"] as? Double else {
     throw SerializationError.missing("aspect ratio")
   }
   guard let filePath = json["file_path"] as? String else {
     throw SerializationError.missing("file path")
   }
    guard let width = json["width"] as? Int else {
      throw SerializationError.missing("width")
    }
   self.id = UUID().hashValue
   self.aspectRatio = aspectRatio
   self.filePath = filePath
    self.width = width
    self.url = "https://image.tmdb.org/t/p/w500\(filePath)"
  }
}
struct MovieVideo: Codable, Identifiable {
  let id: Int
  let name: String
  let key: String
  let site: String
  
  init(json: [String: Any]) throws {
    
    guard let id = json["id"] as? String else {
      throw SerializationError.missing("id")
    }
    guard let name = json["name"] as? String else {
      throw SerializationError.missing("name")
    }
    guard let key = json["key"] as? String else {
      throw SerializationError.missing("key")
    }
    guard let site = json["site"] as? String else {
      throw SerializationError.missing("site")
    }
    self.id = Int(id) ?? UUID().hashValue
    self.name = name
    self.key = key
    self.site = site
  }
}
extension Movie {
  enum Status: Codable {
    case released
    case rumored
    case planned
    case inProduction
    case postProduction
    case canceled
  }
  init(json: [String: Any]) throws {
    guard let id = json["id"] as? Int else {
      throw SerializationError.missing("id")
    }
    guard let title = json["title"] as? String else {
      throw SerializationError.missing("title")
    }
    guard let popularity = json["popularity"] as? Double else {
      throw SerializationError.missing("popularity")
    }
    guard let overview = json["overview"] as? String else {
      throw SerializationError.missing("overview")
    }
    guard let backdropPath = json["backdrop_path"] as? String else {
      throw SerializationError.missing("backdropPath")
    }
    guard let posterPath = json["poster_path"] as? String else {
      throw SerializationError.missing("posterPath")
    }
    if let additionalImages = json["images"] as? [String: Any] {
      guard let backdrops = additionalImages["backdrops"] as? [[String: Any]] else {
        throw SerializationError.missing("backdrops")
      }
      for backdrop in try backdrops.sorted(by: {
        guard let count1 = $0["vote_count"] as? Int,
           let count2 = $1["vote_count"] as? Int else {
          throw SerializationError.missing("vote count")
        }
        return count1 > count2
      }).prefix(3) {
        self.additionalImages.append(try MovieImage(json: backdrop))
      }
    }
    if let additionalVideos = json["videos"] as? [String: Any] {
      guard let results = additionalVideos["results"] as? [[String: Any]] else {
        throw SerializationError.missing("video results")
      }
      for result in results {
        self.additionalVideos.append(try MovieVideo(json: result))
      }
    }
    self.id = id
    self.title = title
    self.popularity = popularity
    self.overview = overview
    self.status = .inProduction
    self.backdropUrl = "https://image.tmdb.org/t/p/w500\(backdropPath)?\(MovieData.apiKey)"
    self.posterUrl = "https://image.tmdb.org/t/p/w154\(posterPath)?\(MovieData.apiKey)"
  }
}
enum SerializationError: Error {
  case missing(String)
  case invalid(String, Any)
}
