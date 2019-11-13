//
//  Card.swift
//  Concentration
//
//  Created by Konstantin Chizhov on 12.11.2019.
//  Copyright © 2019 Konstantin Chizhov. All rights reserved.
//

import Foundation


struct Card {
    var isFaceUp = false;
    var isMatched = false;
    
    var identifier: Int;
    
    static var identifierFactory = 0;
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1;
        return Card.identifierFactory;
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier();
    }
}
