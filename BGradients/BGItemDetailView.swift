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
    
    @State private var pointPair: PointPair = [PointPair].sample[1]
    @State private var showingHelp = false
    
    var body: some View {
        model.selectedItem.map { bgItem in
            ZStack {
                gradient(for: bgItem)
                
                line
                
                VStack(spacing: 0) {
                    dismissView
                    
                    colorLabels(for: bgItem)
                    
                    Text("Tap upper part to rotate and lower to change gradient\nHold color code to copy")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                
                invisibleGradientControlButtons
                
                helpButtonView
            }
            .overlay(HelpOverlay(showingHelp: $showingHelp))
        }
    }
    
    private var helpButtonView: some View {
        VStack {
            Spacer()
            
            Button {
                // help overlay
                withAnimation(.easeInOut(duration: 1)) {
                    showingHelp = true
                }
            } label: {
                Image(systemName: "questionmark.circle")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundStyle(.secondary)
            .padding(.bottom).padding(.bottom).padding(.bottom)
            .offset(x: -80)
        }
    }
    
    private var invisibleGradientControlButtons: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    // rotate buttons
                    Button {
                        withAnimation(.easeInOut(duration: 1)) { previous() }
                    } label: {
                        Rectangle()
                            .fill(Color.clear)
                    }
                    Button {
                        withAnimation(.easeInOut(duration: 1)) { next() }
                    } label: {
                        Rectangle()
                            .fill(Color.clear)
                    }
                }
                .frame(height: geo.size.height / 3 * 2)
                
                HStack {
                    // previous/next buttons
                    Button {
                        withAnimation {
#warning("in fact it's not animatable")
                            model.previousBGItem()
                        }
                    } label: {
                        Rectangle()
                            .fill(Color.clear)
                    }
                    Button {
                        withAnimation {
#warning("in fact it's not animatable")
                            model.nextBGItem()
                        }
                    } label: {
                        Rectangle()
                            .fill(Color.clear)
                    }
                }
                .frame(height: geo.size.height / 3)
            }
        }
    }
    
    private var line: some View {
        Line(pointPair: pointPair)
            .stroke(style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .foregroundStyle(.quaternary)
            .blendMode(.overlay)
            .padding()
    }
    
    private func colorLabels(for bgItem: BGItem) -> some View {
        GeometryReader { geo in
            ZStack(alignment: pointPair.end.alignment) {
                
                ZStack(alignment: pointPair.start.alignment) {
                    Color.clear
                    
                    bgItem.colorValues.first.map { uInt in
                        colorLabel(uInt)
                    }
                }
                
                bgItem.colorValues.last.map { uInt in
                    colorLabel(uInt)
                }
            }
        }
    }
    
    private func colorLabel(_ uInt: UInt32) -> some View {
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
    
    private func next() {
        pointPair = pointPair.next()
    }
    private func previous() {
        pointPair = pointPair.previous()
    }
    
}

@available(iOS 15.0, *)
fileprivate struct HelpOverlay: View {
    
    @Binding var showingHelp: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("Tap anywhere to close")
                    .foregroundStyle(.purple)
                    .padding(.top)
                
                HStack {
                    // rotate buttons
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.mint)
                        .overlay(
                            Label(
                                "Tap area to rotate gradient counterclockwise",
                                systemImage: "arrow.counterclockwise"
                            )
                                .padding()
                        )
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.mint)
                        .overlay(
                            Label(
                                "Tap area to rotate gradient clockwise",
                                systemImage: "arrow.clockwise"
                            )
                                .padding()
                        )
                }
                .frame(height: geo.size.height / 3 * 2)
                
                HStack {
                    // previous/next buttons
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.indigo)
                        .overlay(
                            Text("\(Image(systemName: "chevron.left")) Previous gradient")
                                .padding()
                        )
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.indigo)
                        .overlay(
                            Text("Next gradient \(Image(systemName: "chevron.right"))")
                                .padding()
                        )
                }
                .frame(height: geo.size.height / 3)
            }
        }
        .opacity(showingHelp ? 1 : 0)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                showingHelp = false
            }
        }
    }
}


@available(iOS 15.0, *)
struct BGItemDetailView_Previews: PreviewProvider {
    @StateObject static var model = ViewModel()
    
    static var previews: some View {
        Group {
            BGItemDetailView()
            
            HelpOverlay(showingHelp: .constant(true))
        }
        .environmentObject(model)
        .preferredColorScheme(.dark)
    }
}
