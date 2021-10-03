//
//  Array+Only.swift
//  Memorize
//
//  Created by Jordan Luna on 1/7/21.
//  Copyright © 2021 Jordan Luna. All rights reserved.
//

import Foundation


extension Array {
    var only: Element?{
        count == 1 ? first : nil
    }
}
