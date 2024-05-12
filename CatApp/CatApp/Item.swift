//
//  Item.swift
//  CatApp
//
//  Created by António Fonseca on 12/05/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
