//
//  UnitPoint+alignment.swift
//  BGradients
//
//  Created by Igor Malyarov on 05.07.2021.
//

import SwiftUI

extension UnitPoint {
    var alignment: Alignment {
        switch self {
        case .top:
            return .top
        
        case .topLeading:
            return .topLeading
        
        case .topTrailing:
            return .topTrailing
        
        case .bottom:
            return .bottom
        
        case .bottomLeading:
            return .bottomLeading
        
        case .bottomTrailing:
            return .bottomTrailing
        
        case .leading:
            return .leading
        
        case .trailing:
            return .trailing
        
        default:
            return .center
        }
    }
}
