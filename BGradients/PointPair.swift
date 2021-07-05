//
//  PointPair.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

struct PointPair {
    var start: UnitPoint
    var end: UnitPoint
}

extension PointPair {
    func next() -> PointPair {
        switch (start, end) {
        case (.topLeading, .bottomTrailing):
            return PointPair(start: .top, end: .bottom)
            
        case (.top, .bottom):
            return PointPair(start: .topTrailing, end: .bottomLeading)
        
        case (.topTrailing, .bottomLeading):
            return PointPair(start: .trailing, end: .leading)
        
        case(.trailing, .leading):
            return PointPair(start: .bottomTrailing, end: .topLeading)
        
        case(.bottomTrailing, .topLeading):
            return PointPair(start: .bottom, end: .top)
        
        case (.bottom, .top):
            return PointPair(start: .bottomLeading, end: .topTrailing)
        
        case (.bottomLeading, .topTrailing):
            return PointPair(start: .leading, end: .trailing)
        
        case (.leading, .trailing):
            return PointPair(start: .topLeading, end: .bottomTrailing)
        
        default:
            return PointPair(start: .center, end: .center)
        }
    }
    
    func previous() -> PointPair {
        switch (start, end) {
        case (.topLeading, .bottomTrailing):
            return PointPair(start: .leading, end: .trailing)
            
        case (.top, .bottom):
            return PointPair(start: .topLeading, end: .bottomTrailing)
        
        case (.topTrailing, .bottomLeading):
            return PointPair(start: .top, end: .bottom)
        
        case(.trailing, .leading):
            return PointPair(start: .topTrailing, end: .bottomLeading)
        
        case(.bottomTrailing, .topLeading):
            return PointPair(start: .trailing, end: .leading)
        
        case (.bottom, .top):
            return PointPair(start: .bottomTrailing, end: .topLeading)
        
        case (.bottomLeading, .topTrailing):
            return PointPair(start: .bottom, end: .top)
        
        case (.leading, .trailing):
            return PointPair(start: .bottomLeading, end: .topTrailing)
        
        default:
            return PointPair(start: .center, end: .center)
        }
    }
}

extension Array where Element == PointPair {
    static let vertical = [
        PointPair(start: .top, end: .bottom),
        PointPair(start: .bottom, end: .top)
    ]
    
    static let horizontal = [
        PointPair(start: .leading, end: .trailing),
        PointPair(start: .trailing, end: .leading)
    ]
    
    static let diagonal1 = [
        PointPair(start: .topLeading, end: .bottomTrailing),
        PointPair(start: .bottomTrailing, end: .topLeading)
    ]
    
    static let diagonal2 = [
        PointPair(start: .topTrailing, end: .bottomLeading),
        PointPair(start: .bottomLeading, end: .topTrailing)
    ]
    
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
