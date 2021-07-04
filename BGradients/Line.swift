//
//  Line.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

struct Line: Shape {
    var pointPair: PointPair
    
    var animatableData: AnimatablePair<AnimatablePair<Double, Double>, AnimatablePair<Double, Double>> {
        get {
            AnimatablePair(
                AnimatablePair(pointPair.start.x, pointPair.start.y),
                AnimatablePair(pointPair.end.x, pointPair.end.y)
            )
        }
        set {
            pointPair.start.x = newValue.first.first
            pointPair.start.y = newValue.first.second
            pointPair.end.x = newValue.second.first
            pointPair.end.y = newValue.second.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(
                x: pointPair.start.x * rect.width,
                y: pointPair.start.y * rect.height
            ))
            path.addLine(to: CGPoint(
                x: pointPair.end.x * rect.width,
                y: pointPair.end.y * rect.height
            ))
        }
    }
}

struct TestLine: View {
    @State private var pointPair = PointPair(
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
            
            Line(pointPair: pointPair)
                .stroke(style: .init(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(.blue)
                .padding()
        }
    }
    
    private func next() {
        pointPair = pointPair.next()
    }
    
}


struct Line_Previews: PreviewProvider {
    static var previews: some View {
        TestLine()
    }
}
