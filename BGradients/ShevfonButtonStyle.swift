//
//  SwiftUIView.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct ShevfonButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.iconOnly)
            .imageScale(.large)
            .padding()
            .padding(.vertical)
//            .foregroundStyle(.regularMaterial)
            .background(
                .quaternary,
                in: RoundedRectangle(cornerRadius: 12)
            )
            .blendMode(.overlay)
    }
}

@available(iOS 15.0, *)
struct ShevfonButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.mint
            
            Button("ShevfonButtonStyle") {}
        }
        .buttonStyle(ShevfonButtonStyle())
        .preferredColorScheme(.dark)
    }
}
