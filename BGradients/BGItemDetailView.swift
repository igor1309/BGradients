//
//  BGItemDetailView.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct BGItemDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var model: ViewModel
    
    @State private var pointIndex = 0
    
    private var point: PointPair {
        [PointPair].sample[pointIndex]
    }
    
    private let pointPairs = [PointPair].sample
    
    private func next() {
        let next = (pointIndex + 1) % pointPairs.count
        pointIndex = next
    }
    
    var body: some View {
        model.selectedItem.map { bgItem in
            ZStack(alignment: .topTrailing) {
                gradient(for: bgItem)
                
                VStack {
                    dismissView
                    Spacer()
                    chevronButtons
                    Spacer()
                    Text("Tab to rotate gradient")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
            .transition(
                .asymmetric(
                    insertion: .move(edge: .leading),
                    removal: .move(edge: .trailing)
                )
            )
        }
    }
    
    private var dismissView: some View {
        Capsule()
            .foregroundStyle(.tertiary)
            .frame(width: 80, height: 6)
            .padding(.top, 6)
//        HStack {
//            Spacer()
//
//            Button {
//                withAnimation {
//                    dismiss()
//                }
//            } label: {
//                Label("Close Gradient", systemImage: "xmark.circle")
//                    .labelStyle(.iconOnly)
//                    .imageScale(.large)
//                    .padding()
//            }
//        }
    }
    
    private var chevronButtons: some View {
        HStack {
            priviousButton
            
            Spacer()
            
            nextButton
        }
    }
    
    private var priviousButton: some View {
        Button {
            withAnimation {
                model.previousBGItem()
            }
        } label: {
            Label("Close Gradient", systemImage: "chevron.left")
        }
        .buttonStyle(ShevfonButtonStyle())
        .padding()
    }
    
    private var nextButton: some View {
        Button {
            withAnimation {
                model.nextBGItem()
            }
        } label: {
            Label("Close Gradient", systemImage: "chevron.right")
        }
        .buttonStyle(ShevfonButtonStyle())
        .padding()
    }
    
    private func gradient(for bgItem: BGItem) -> some View {
        LinearGradient(
            gradient: Gradient(colors: bgItem.colors),
            startPoint: point.start,
            endPoint: point.end
        )
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation { next() }
            }
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
