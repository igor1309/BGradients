//
//  Direction.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

struct Direction {
    var start: UnitPoint
    var end: UnitPoint
}

extension Direction {
    func next() -> Direction {
        switch (start, end) {
        case (.topLeading, .bottomTrailing):
            return Direction(start: .top, end: .bottom)
            
        case (.top, .bottom):
            return Direction(start: .topTrailing, end: .bottomLeading)
        
        case (.topTrailing, .bottomLeading):
            return Direction(start: .trailing, end: .leading)
        
        case(.trailing, .leading):
            return Direction(start: .bottomTrailing, end: .topLeading)
        
        case(.bottomTrailing, .topLeading):
            return Direction(start: .bottom, end: .top)
        
        case (.bottom, .top):
            return Direction(start: .bottomLeading, end: .topTrailing)
        
        case (.bottomLeading, .topTrailing):
            return Direction(start: .leading, end: .trailing)
        
        case (.leading, .trailing):
            return Direction(start: .topLeading, end: .bottomTrailing)
        
        default:
            return Direction(start: .center, end: .center)
        }
    }
    
    func previous() -> Direction {
        switch (start, end) {
        case (.topLeading, .bottomTrailing):
            return Direction(start: .leading, end: .trailing)
            
        case (.top, .bottom):
            return Direction(start: .topLeading, end: .bottomTrailing)
        
        case (.topTrailing, .bottomLeading):
            return Direction(start: .top, end: .bottom)
        
        case(.trailing, .leading):
            return Direction(start: .topTrailing, end: .bottomLeading)
        
        case(.bottomTrailing, .topLeading):
            return Direction(start: .trailing, end: .leading)
        
        case (.bottom, .top):
            return Direction(start: .bottomTrailing, end: .topLeading)
        
        case (.bottomLeading, .topTrailing):
            return Direction(start: .bottom, end: .top)
        
        case (.leading, .trailing):
            return Direction(start: .bottomLeading, end: .topTrailing)
        
        default:
            return Direction(start: .center, end: .center)
        }
    }
}

extension Array where Element == Direction {
    static let vertical = [
        Direction(start: .top, end: .bottom),
        Direction(start: .bottom, end: .top)
    ]
    
    static let horizontal = [
        Direction(start: .leading, end: .trailing),
        Direction(start: .trailing, end: .leading)
    ]
    
    static let diagonal1 = [
        Direction(start: .topLeading, end: .bottomTrailing),
        Direction(start: .bottomTrailing, end: .topLeading)
    ]
    
    static let diagonal2 = [
        Direction(start: .topTrailing, end: .bottomLeading),
        Direction(start: .bottomLeading, end: .topTrailing)
    ]
    
    static let sample = [
        Direction(start: .leading, end: .trailing),
        Direction(start: .topLeading, end: .bottomTrailing),
        Direction(start: .top, end: .bottom),
        Direction(start: .topTrailing, end: .bottomLeading),
        Direction(start: .trailing, end: .leading),
        Direction(start: .bottomTrailing, end: .topLeading),
        Direction(start: .bottom, end: .top),
        Direction(start: .bottomLeading, end: .topTrailing)
    ]
}
