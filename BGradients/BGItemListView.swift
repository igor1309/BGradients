//
//  BGItemListView.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

extension BGItem {
    var linearGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}

@available(iOS 15.0, *)
struct BGItemListView: View {
    @StateObject private var model = ViewModel()
    
    @State private var isPresented = false
    
    var body: some View {
        List {
            ForEach(model.bgItems) { bgItem in
                BGItemListRowView(bgItem: bgItem)
                    .listRowBackground(bgItem.linearGradient)
                    .listRowSeparator(.hidden)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            model.selectedItem = bgItem
                            isPresented = true
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Gradients")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isPresented) {
            BGItemDetailView()
                .environmentObject(model)
        }
    }
}

@available(iOS 15.0, *)
struct BGItemListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BGItemListView()
        }
        .preferredColorScheme(.dark)
    }
}
