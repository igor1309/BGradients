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
                    
                    // chevronButtons
                    Text("Tap upper part to rotate and lower to change gradient")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                
                buttons
                
                helpButtonView
            }
            .overlay(helpOverlay)
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
                    .padding()
            }
            .foregroundStyle(.secondary)
            .padding(.bottom).padding(.bottom)
            .offset(x: -80)
        }
    }
    
    private var helpOverlay: some View {
        GeometryReader { geo in
            VStack {
                Text("Tap anywhere to close")
                    .foregroundStyle(.indigo)
                    .padding(.top)
                
                HStack {
                    // rotate buttons
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.mint)
                        .overlay(
                            Text("Tap area to rotate gradient counterclockwise")
                                .padding()
                        )
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.mint)
                        .overlay(
                            Text("Tap area to rotate gradient clockwise")
                                .padding()
                        )
                }
                .frame(height: geo.size.height / 3 * 2)
                
                HStack {
                    // previous/next buttons
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.indigo)
                        .overlay(
                            Text("Previous gradient")
                                .padding()
                        )
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.indigo)
                        .overlay(
                            Text("Next gradient")
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
    
    private var buttons: some View {
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
    
    private func next() {
        pointPair = pointPair.next()
    }
    private func previous() {
        pointPair = pointPair.previous()
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
