//
//  PosterView.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import SwiftUI
import struct Kingfisher.KFImage
import struct Kingfisher.AnyModifier

struct PosterView: View {

  let posterUrl: String
  var body: some View {
    KFImage(URL(string: posterUrl))
      .requestModifier(Kingfisher.AnyModifier.authModifier)
      .placeholder({ progress in
        ProgressView(progress)
      })
      .resizable()
      .aspectRatio(contentMode: .fit)
      .cornerRadius(10)
  }
}

struct PosterView_Previews: PreviewProvider {
  static private let sampleUrl = #"""
                  https://upload.wikimedia# .org/wikipedia/en/thumb/1/14/Tenet_movie_poster#
                  .jpg/220px-Tenet_movie_poster.jpg
                  """#
  static var previews: some View {
      PosterView(posterUrl: sampleUrl)
    }
}
