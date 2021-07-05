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
    
    @State private var direction: Direction = [Direction].sample[1]
    @State private var showingHelp = false
    
    var body: some View {
        model.selectedItem.map { bgItem in
            ZStack {
                gradient(for: bgItem)
                
                VStack(spacing: 0) {
                    dismissView
                    
                    ZStack {
                        line
                        colorLabels(for: bgItem)
                        invisibleGradientControlButtons
                    }
                    
                    helpButtonView
                }
            }
            .overlay(HelpOverlay(showingHelp: $showingHelp))
        }
    }
    
#warning("transition not working")
    private func gradient(for bgItem: BGItem) -> some View {
        LinearGradient(
            gradient: Gradient(colors: bgItem.colors),
            startPoint: direction.start,
            endPoint: direction.end
        )
            .ignoresSafeArea()
        //            .transition(
        //                .asymmetric(
        //                    insertion: .move(edge: .leading),
        //                    removal: .move(edge: .trailing)
        //                )
        //            )
    }
    
    private var dismissView: some View {
        Capsule()
            .foregroundStyle(.tertiary)
            .controlProminence(.increased)
            .frame(width: 60, height: 5)
            .padding(.top, 8)
    }
    
    private var line: some View {
        Line(direction: direction)
            .stroke(style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .foregroundStyle(.quaternary)
            .blendMode(.overlay)
            .padding()
    }
    
    private func colorLabels(for bgItem: BGItem) -> some View {
        GeometryReader { geo in
            ZStack(alignment: direction.end.alignment) {
                
                ZStack(alignment: direction.start.alignment) {
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
    
    private var invisibleGradientControlButtons: some View {
        func invisibleLabel() -> some View {
            Rectangle().fill(Color.clear)
        }
        
        return GeometryReader { geo in
            VStack {
                // rotate buttons
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            previousGradientDirection()
                        }
                    } label: {
                        invisibleLabel()
                    }
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            nextGradientDirection()
                        }
                    } label: {
                        invisibleLabel()
                    }
                }
                .frame(height: geo.size.height / 3 * 2)
                
                // previous/next buttons
                HStack {
                    Button {
#warning("in fact it's not animatable")
                        withAnimation(.easeInOut(duration: 1)) {
                            model.previousBGItem()
                        }
                    } label: {
                        invisibleLabel()
                    }
                    Button {
#warning("in fact it's not animatable")
                        withAnimation(.easeInOut(duration: 1)) {
                            model.nextBGItem()
                        }
                    } label: {
                        invisibleLabel()
                    }
                }
                .frame(height: geo.size.height / 3)
            }
        }
    }
    
    private func nextGradientDirection() {
        direction = direction.next()
    }
    private func previousGradientDirection() {
        direction = direction.previous()
    }
    
    private var helpButtonView: some View {
        HStack(alignment: .top, spacing: 9) {
            Button {
                // help overlay
                withAnimation(.easeInOut(duration: 1)) {
                    showingHelp = true
                }
            } label: {
                Image(systemName: "questionmark.circle")
                    .imageScale(.large)
            }
            
            VStack {
                Text("Tap to rotate or change gradient")
                Text("Hold color code to copy")
            }
            .font(.caption)
        }
        .foregroundStyle(.secondary)
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
                
                // rotate buttons
                HStack {
                    area(color: .mint) {
                        Label(
                            "Tap area to rotate gradient counterclockwise",
                            systemImage: "arrow.counterclockwise"
                        )
                    }
                    area(color: .mint) {
                        Label(
                            "Tap area to rotate gradient clockwise",
                            systemImage: "arrow.clockwise"
                        )
                    }
                }
                .frame(height: geo.size.height / 3 * 2)
                
                // previous/next buttons
                HStack {
                    area(color: .indigo) {
                        Text("\(Image(systemName: "chevron.left")) Previous gradient")
                    }
                    area(color: .indigo) {
                        Text("Next gradient \(Image(systemName: "chevron.right"))")
                    }
                }
                .frame(height: geo.size.height / 3)
            }
        }
        .background(.regularMaterial)
        .opacity(showingHelp ? 1 : 0)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)) {
                showingHelp = false
            }
        }
    }
    
    private func area<V: View>(
        color: Color,
        cornerRadius: Double = 12,
        label: () -> V
    ) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .overlay(label().padding())
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
