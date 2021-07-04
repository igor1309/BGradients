//
//  PointPair.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

struct PointPair {
    let start: UnitPoint
    let end: UnitPoint
}

extension Array where Element == PointPair {
    static let sample = [
        PointPair(start: .leading, end: .trailing),
        PointPair(start: .topLeading, end: .bottomTrailing),
        PointPair(start: .top, end: .bottom),
        PointPair(start: .topTrailing, end: .bottomLeading),
        PointPair(start: .trailing, end: .leading),
        PointPair(start: .bottomTrailing, end: .topLeading),
        PointPair(start: .bottom, end: .top),
        PointPair(start: .bottomLeading, end: .topTrailing)
    ]
}
