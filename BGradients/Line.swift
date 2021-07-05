//
//  Line.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

struct Line: Shape {
    var direction: Direction
    
    var animatableData: AnimatablePair<AnimatablePair<Double, Double>, AnimatablePair<Double, Double>> {
        get {
            AnimatablePair(
                AnimatablePair(direction.start.x, direction.start.y),
                AnimatablePair(direction.end.x, direction.end.y)
            )
        }
        set {
            direction.start.x = newValue.first.first
            direction.start.y = newValue.first.second
            direction.end.x = newValue.second.first
            direction.end.y = newValue.second.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(
                x: direction.start.x * rect.width,
                y: direction.start.y * rect.height
            ))
            path.addLine(to: CGPoint(
                x: direction.end.x * rect.width,
                y: direction.end.y * rect.height
            ))
        }
    }
}

struct TestLine: View {
    @State private var direction = Direction(
        start: .topLeading,
        end: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.2)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.linear(duration: 2)) {
                        next()
                    }
                }
            
            Line(direction: direction)
                .stroke(style: .init(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .padding()
        }
    }
    
    private func next() {
        direction = direction.next()
    }
    
}


struct Line_Previews: PreviewProvider {
    static var previews: some View {
        TestLine()
    }
}
