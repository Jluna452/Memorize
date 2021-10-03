//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jordan Luna on 8/28/20.
//  Copyright © 2020 Jordan Luna. All rights reserved.
//

import SwiftUI

//this is the veiwModel
//communicates the changes from model to view
//allows view to see aspects of model


class EmojiMemoryGame: ObservableObject{
    @Published private var model = EmojiMemoryGame.createMemoryGame()
        
    static private func createMemoryGame()-> MemoryGame<String>{
        let emojis: Array<String> = ["👻","🎃","🕷", "🤨","👽","💀","🕸","🧛🏻‍♀️","🐙","🦇","🦉","💩"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)){ Index in
            return emojis[Index]
        }
    }
        
        
        
//    MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    
    
//    MARK: - Intent(s)
    func chooseCard(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func resetGame(){
        model = EmojiMemoryGame.createMemoryGame()
    }
    
}

//ObservableObject: allows for us to say that view will be watching this class for changing variables marked with @published
//@published: observers of the view model are automatically notified when the @published variable is
//changed and reload its views dependent on it
