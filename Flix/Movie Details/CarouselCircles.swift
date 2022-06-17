//
//  CarouselCircles.swift
//  Flix
//
//  Created by Derek Chang on 6/8/22.
//

import SwiftUI

struct CarouselCircles: View {
  let numCircles: Int
  @Binding var selected: Int
    var body: some View {
        HStack(spacing: 20) {
          ForEach(0..<numCircles) { idx in
            if idx == selected {
              Circle()
                .fill(.white)
                .opacity(0.95)
            } else {
              Circle()
                .inset(by: 1)
                .stroke(.white, lineWidth: 2)
                .opacity(0.8)
            }
          }
        }
        .padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
        .onTapGesture {
        selected = (selected+1) % numCircles
      }.animation(.easeInOut, value: selected)
    }
}
struct CarouselCircles_Previews: PreviewProvider {
    static var previews: some View {
      CarouselCircles(numCircles: 4, selected: Binding.constant(0))
        .frame(width: 200, height: 30)
        .background(.black)
    }
}
