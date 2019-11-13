//
//  ViewController.swift
//  Concentration
//
//  Created by Konstantin Chizhov on 12.11.2019.
//  Copyright © 2019 Konstantin Chizhov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var game = Concentration(numberOfPairs: cardButtons.count / 2)

    @IBAction func tocuhCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if game.choseCard(at: cardNumber) {
                flipCount += 1;
            }
            updateViewFromModel()
        } else {
            print("Elemnt not found")
        }
    }
    
    @IBAction func newGameTiuch(_ sender: UIButton) {
        game = Concentration(numberOfPairs: cardButtons.count / 2)
        flipCount = 0;
        updateViewFromModel()
        emojiChoices = ["🤪", "🧐", "🤓", "😎", "😴", "🛠", "⏰", "📟"]
    }
    
    func updateViewFromModel()
    {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = UIColor.white
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = card.isMatched ? UIColor.white.withAlphaComponent(0.0) :  UIColor.systemOrange
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    var emojiChoices = ["🤪", "🧐", "🤓", "😎", "😴", "🛠", "⏰", "📟"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex);
        }
        
        return emoji[card.identifier] ?? "?";
    }
    
}

