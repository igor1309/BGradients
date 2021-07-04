//
//  BGItem.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import Foundation
import SwiftUI

struct BGItem: Identifiable, Codable {
    let id: UUID
#warning("change to primary")
    let isTextColorWhite: Bool
    let opacity: Double
    let colorValues: [UInt32]
    
    var colors: [Color] { colorValues.map { Color.init($0) } }
}

extension BGItem {
    static let sample = BGItem(
        id: UUID(),
        isTextColorWhite: true,
        opacity: 1,
        colorValues: gradientColors[5])
}

extension Array where Element == BGItem {
    static let sample = gradientColors.map {
        BGItem(
            id: UUID(),
            isTextColorWhite: false,
            opacity: 1,
            colorValues: $0
        )
    }
}
