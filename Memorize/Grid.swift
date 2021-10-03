//
//  Grid.swift
//  Memorize
//
//  Created by Jordan Luna on 1/5/21.
//  Copyright © 2021 Jordan Luna. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    private var items:[Item]
    private var viewForItems: (Item) -> ItemView
    
    
    init(_ items: [Item], viewForItem: @escaping (Item)->ItemView) {
        self.items = items
        self.viewForItems = viewForItem
    }

    var body: some View {
        GeometryReader{ geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    //fix for the "self" issues in vids, no longer needed
    private func body(for layout: GridLayout) -> some View{
        ForEach(items){item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item:Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
 
        return Group{
            if index != nil{
                self.viewForItems(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index!) )
            }
        }
    }
    
    
    
    

}

//@escaping: When a closure is marked as escaping in Swift, it means that the closure will outlive, or leave the scope (function) that you've passed it to.



//Group will return an empty view if index is nil, allows us to not have to return something
