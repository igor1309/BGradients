//
//  BGItemDetailView.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct BGItemDetailView: View {
    
    @EnvironmentObject private var model: ViewModel
    
    @State private var pointIndex = 0
    
    @State private var pointPair: PointPair = [PointPair].sample[0]
    
    private let pointPairs = [PointPair].sample
    
    private func next() {
        let next = (pointIndex + 1) % pointPairs.count
        pointIndex = next
        pointPair = pointPairs[pointIndex]
    }
    
    var body: some View {
        model.selectedItem.map { bgItem in
            ZStack {
                gradient(for: bgItem)
                
                line
                
                VStack(spacing: 0) {
                    dismissView
                    
                    colorLabels(for: bgItem)
                    
                    chevronButtons
                    
                    Text("Tab to rotate gradient")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
        }
    }
    
    private var line: some View {
        Line(pointPair: pointPair)
            .stroke(style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .foregroundStyle(.quaternary)
            .blendMode(.overlay)
            .padding()
        //            .padding(.vertical)
        //        // .padding(.vertical)
        //            .padding(.vertical)
        //        // .padding(.bottom).padding(.bottom)
    }
    
    private func colorLabels(for bgItem: BGItem) -> some View {
        GeometryReader { geo in
            ZStack(alignment: pointPair.end.alignment) {
                
                ZStack(alignment: pointPair.start.alignment) {
                    Color.clear
                    
                    bgItem.colorValues.first.map { uInt in
                        textForColor(uInt)
                    }
                }
                
                bgItem.colorValues.last.map { uInt in
                    textForColor(uInt)
                }
            }
        }
    }
    
    private func textForColor(_ uInt: UInt32) -> some View {
        Text(String(format: "%02X", uInt))
            .foregroundStyle(.secondary)
            .controlProminence(.increased)
        // .foregroundColor(bgItem.colors[0])
            .font(.subheadline)
            .textSelection(.enabled)
            .padding()
    }
    
    private var dismissView: some View {
        Capsule()
            .foregroundStyle(.tertiary)
            .controlProminence(.increased)
            .frame(width: 60, height: 5)
            .padding(.top, 8)
    }
    
    private var chevronButtons: some View {
        HStack {
            previousButton
            Spacer()
            nextButton
        }
        //        .padding(.bottom)
        // .padding(.bottom)
    }
    
    private var previousButton: some View {
        Button {
            withAnimation {
#warning("in fact it's not animatable")
                model.previousBGItem()
            }
        } label: {
            Label("Close Gradient", systemImage: "chevron.left")
        }
        .buttonStyle(ShevfonButtonStyle())
        .padding(.horizontal)
    }
    
    private var nextButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 2)) {
#warning("in fact it's not animatable")
                model.nextBGItem()
            }
        } label: {
            Label("Close Gradient", systemImage: "chevron.right")
        }
        .buttonStyle(ShevfonButtonStyle())
        .padding(.horizontal)
    }
    
#warning("transition not working")
    private func gradient(for bgItem: BGItem) -> some View {
        LinearGradient(
            gradient: Gradient(colors: bgItem.colors),
            startPoint: pointPair.start,
            endPoint: pointPair.end
        )
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) { next() }
            }
        //            .transition(
        //                .asymmetric(
        //                    insertion: .move(edge: .leading),
        //                    removal: .move(edge: .trailing)
        //                )
        //            )
    }
    
}

@available(iOS 15.0, *)
struct BGItemDetailView_Previews: PreviewProvider {
    @StateObject static var model = ViewModel()
    
    static var previews: some View {
        BGItemDetailView()
            .environmentObject(model)
            .preferredColorScheme(.dark)
    }
}
