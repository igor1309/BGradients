//
//  BGItemListRowView.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct BGItemListRowView: View {
    let bgItem: BGItem
    
    var body: some View {
        HStack {
            ForEach(bgItem.colorValues, id: \.self) { colorValue in
                Text(String(format: "%02X", colorValue))
                    .font(.subheadline)
                    .textSelection(.enabled)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
        }
    }
}

@available(iOS 15.0, *)
struct BGItemListRowView_Previews: PreviewProvider {
    static var previews: some View {
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            BGItemListRowView(bgItem: .sample)
        }
    }
}
