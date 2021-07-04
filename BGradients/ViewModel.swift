//
//  ViewModel.swift
//  BGradients
//
//  Created by Igor Malyarov on 04.07.2021.
//

import SwiftUI
@available(iOS 15.0, *)
    
    final class ViewModel: ObservableObject {
        @Published private(set) var bgItems: [BGItem] = [] {
            didSet {
                saveJSON(data: bgItems, filename: "bgItems.json")
            }
        }
        
        @Published var selectedItem: BGItem?
        
        init() {
            bgItems = loadBGItems()
        }
        
        func nextBGItem() {
            guard let id = selectedItem?.id,
                  let index = bgItems.firstIndex(where: { $0.id == id }) else { return }
            let next = (index + 1) % bgItems.count
            selectedItem = bgItems[next]
        }
        
        func previousBGItem() {
            guard let id = selectedItem?.id,
                  let index = bgItems.firstIndex(where: { $0.id == id }) else { return }
            let next = (index - 1 + bgItems.count) % bgItems.count
            selectedItem = bgItems[next]
        }
        
        private func loadBGItems() -> [BGItem] {
            guard let items: [BGItem] = load("bgItems.json") else {
                let items = [BGItem].sample
                
                return items
            }
            
            return items
        }
    }

