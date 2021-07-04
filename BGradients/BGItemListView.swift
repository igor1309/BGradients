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
    
    var body: some View {
        List {
            ForEach(model.bgItems) { bgItem in
                BGItemListRowView(bgItem: bgItem)
                    .listRowBackground(bgItem.linearGradient)
                    .listRowSeparator(.hidden)
            }
        }
    }
}

@available(iOS 15.0, *)
struct BGItemListView_Previews: PreviewProvider {
    static var previews: some View {
        BGItemListView()
    }
}
