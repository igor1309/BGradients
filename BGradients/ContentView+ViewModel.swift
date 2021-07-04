//
//  ViewModel.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI

@available(iOS 15.0, *)
extension BGItemListView {
    
    final class ViewModel: ObservableObject {
        @Published private(set) var bgItems: [BGItem] = [] {
            didSet {
                saveJSON(data: bgItems, filename: "bgItems.json")
            }
        }
        
        init() {
            bgItems = loadBGItems()
        }
        
        private func loadBGItems() -> [BGItem] {
            guard let items: [BGItem] = load("bgItems.json") else {
                let items = [BGItem].sample
                
                return items
            }
            
            return items
        }
    }
    
}
