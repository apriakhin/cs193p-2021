//
//  MemoryGame.swift
//  Memorize
//
//  Created by Anton Priakhin on 05.01.2022.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    private var flippedCardIds: Set<Int> = []
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        cards[index].isFaceUp.toggle()
                        
                        if flippedCardIds.contains(where: { $0 == cards[index].id }) {
                            score -= 1
                        } else {
                            flippedCardIds.insert(cards[index].id)
                        }
                    }
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
