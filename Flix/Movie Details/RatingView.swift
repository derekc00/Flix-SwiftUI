//
//  RatingView.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import SwiftUI

struct RatingView: View {
  @State var rating: Double
  @State var trim: Double = 0
  var body: some View {
    ZStack {
      Text(String(describing: rating))
        .font(.subheadline)
      Circle()
        .trim(from: 0, to: trim)
        .stroke(
          AngularGradient(colors: [.red, .yellow, .green],
                          center: .center,
                          startAngle: .degrees(-10),
                          endAngle: .degrees(350)),
          style: StrokeStyle(lineWidth: 10,
                             lineCap: .round)
        )
        .rotationEffect(.degrees(-90))
        .animation(.easeInOut(duration: 1.0), value: trim)
    }
    .padding()
    .onAppear {
      trim = rating / 10
    }
  }
}

struct RatingView_Previews: PreviewProvider {
  static var rating: Double = 5.0
  static var previews: some View {
    RatingView(rating: rating)
        .frame(width: 100, height: 100)
    }
}
