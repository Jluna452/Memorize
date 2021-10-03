//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Jordan Luna on 1/6/21.
//  Copyright © 2021 Jordan Luna. All rights reserved.
//

import Foundation


extension Array where Element: Identifiable{
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if matching.id == self[index].id {
                return index
            }
        }
        return nil
    }
}
