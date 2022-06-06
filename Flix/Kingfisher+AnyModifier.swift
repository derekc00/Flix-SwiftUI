//
//  Kingfisher+AnyModifier.swift
//  Flix
//
//  Created by Derek Chang on 6/6/22.
//

import Foundation
import Kingfisher
import SwiftUI

public extension Kingfisher.AnyModifier {
  static let authModifier = AnyModifier { request in
    var modifiedRequest = request
    modifiedRequest.addValue("Bearer <<access-token>>",
                             forHTTPHeaderField: "Authentication")
    return modifiedRequest
  }
}
