//
//  Board.swift
//  Trello-likeApp
//
//  Created by Mikhail Ustyantsev on 06.11.2023.
//

import Foundation

final class Board: Codable {
    
    var title: String
    var items: [String]
    
    init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
    
}
