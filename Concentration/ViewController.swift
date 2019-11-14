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
            flipCountLabel.text = "Count flips: \(flipCount)"
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
    
    var themes: [Theme]!
    
    var theme: Theme!
    
    override func viewDidLoad() {
        themes = [];
        themes.append(Theme(Name: "halloween", backgroundColor: UIColor.black, faceColor: UIColor.white, coverColor:UIColor.systemOrange, emoji: ["👻", "💀", "👽", "🎃", "👹", "🦇", "🕷", "🧛🏻‍♂️"]));
        themes.append(Theme(Name: "newyear", backgroundColor: UIColor(red:0.49, green:0.84, blue:0.92, alpha:1.0), faceColor: UIColor.white, coverColor: UIColor(red:0.06, green:0.15, blue:0.34, alpha:1.0), emoji: ["🥶", "🎅", "🧣", "❄️", "☃️", "🎉", "🎁", "🎄"]));
        themes.append(Theme(Name: "animals", backgroundColor: UIColor(red:0.57, green:0.64, blue:0.20, alpha:1.0), faceColor: UIColor.white, coverColor: UIColor(red:0.34, green:0.39, blue:0.16, alpha:1.0), emoji: ["🦄", "🐬", "🦡", "🦍", "🐝", "🐊", "🦖", "🦀"]));
        themes.append(Theme(Name: "vegetables", backgroundColor: UIColor(red:0.70, green:0.89, blue:0.71, alpha:1.0), faceColor: UIColor.white, coverColor: UIColor(red:0.98, green:0.60, blue:0.52, alpha:1.0), emoji: ["🍄", "🥑", "🍆", "🍅", "🥦", "🥬", "🌽", "🌶"]));
        themes.append(Theme(Name: "faces", backgroundColor: UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0), faceColor: UIColor.white, coverColor: UIColor(red:0.49, green:0.64, blue:0.66, alpha:1.0), emoji: ["😍", "😎", "🥳", "🙃", "😢", "🤬", "🤤", "🤡"]));
        themes.append(Theme(Name: "sports", backgroundColor: UIColor(red:0.11, green:0.11, blue:0.17, alpha:1.0), faceColor: UIColor.white, coverColor: UIColor(red:0.24, green:0.74, blue:0.76, alpha:1.0), emoji: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏉", "🎱"]));
        
        setRandomTheme();
    }
    
    func setRandomTheme() {
        theme = themes[themes.count.random()]
        emojiChoices = theme.emoji
        view.backgroundColor = theme.backgroundColor
        updateViewFromModel()
    }
    
    @IBAction func newGameTouch(_ sender: UIButton) {
        game = Concentration(numberOfPairs: cardButtons.count / 2)
        flipCount = 0;
        updateViewFromModel()
        
        setRandomTheme();
    }
    
    func updateViewFromModel()
    {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.backgroundColor = theme.faceColor
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = card.isMatched ? UIColor.white.withAlphaComponent(0.0) : theme.coverColor
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    var emojiChoices = ["👻", "💀", "👽", "🎃", "👹", "🦇", "🕷", "🧛🏻‍♂️"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String
    {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.random());
        }
        
        return emoji[card.identifier] ?? "?";
    }
    
}

extension Int {
    func random() -> Int {
        return Int(arc4random_uniform(UInt32(self)));
    }
}
