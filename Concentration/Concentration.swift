//
//  Concentration.swift
//  Concentration
//
//  Created by Konstantin Chizhov on 12.11.2019.
//  Copyright © 2019 Konstantin Chizhov. All rights reserved.
//

import Foundation


class Concentration
{
    private(set) var cards = [Card] ();
    
    private(set) var flipCount = 0;
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        set (newIndex) {
            for flipDownIndex in cards.indices {
                if flipDownIndex == newIndex {
                    flipCount += 1
                }
                    
                cards[flipDownIndex].isFaceUp = flipDownIndex == newIndex
            }
        }
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly;
        }
    }
    
    func choseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                flipCount += 1
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairs: Int) {
        flipCount = 0;
        for _ in 1...numberOfPairs {
            let card = Card();
            
            cards += [card, card];
        }
        cards.shuffle();
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil;
    }
}
