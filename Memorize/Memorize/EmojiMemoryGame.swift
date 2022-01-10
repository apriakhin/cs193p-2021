//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Anton Priakhin on 05.01.2022.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String>
    @Published private var memoryTheme: MemoryTheme<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }
    
    var score: Int {
        memoryGame.score
    }
    
    var themeName: String {
        memoryTheme.name
    }
    
    var themeColor: Color {
        switch memoryTheme.color {
        case "red": return .red
        case "yellow": return .yellow
        case "green": return .green
        case "orange": return .orange
        case "brown": return .brown
        case "blue": return .blue
        default: return .gray
        }
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        memoryGame.choose(card)
    }
    
    func startNewGame() {
        let memoryTheme = MemoryTheme<String>(themes: LocalConstants.themes)
        let numberOfPairs = memoryTheme.numberOfPairs > memoryTheme.contents.count ? memoryTheme.contents.count : memoryTheme.numberOfPairs
        let emojis = memoryTheme.contents.shuffled()
        
        self.memoryGame = MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
        self.memoryTheme = memoryTheme
    }
    
    // MARK: - Init
    
    init() {
        let memoryTheme = MemoryTheme<String>(themes: LocalConstants.themes)
        let numberOfPairs = memoryTheme.numberOfPairs > memoryTheme.contents.count ? memoryTheme.contents.count : memoryTheme.numberOfPairs
        let emojis = memoryTheme.contents.shuffled()
        
        self.memoryGame = MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
        self.memoryTheme = memoryTheme
    }
}

private extension EmojiMemoryGame {
    enum LocalConstants {
        static let themes = [
            MemoryTheme<String>.Theme(
                name: "Vehicles",
                contents: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🚲", "🛴", "🛵", "🏍", "🛺", "🚡", "🚃", "🚤", "🛶", "🚁", "🚀", "✈️", "🛳"],
                color: "red"
            ),
            MemoryTheme<String>.Theme(
                name: "Clothes",
                contents: ["🧥", "🥼", "🦺", "👚", "👕", "👖", "👗", "👔", "🩳", "🩲", "👙", "🩱", "👘", "🥻", "🩴", "🥿", "🧢", "🎩", "🧣", "🧤", "🧦", "🕶", "💼", "👓"],
                color: "yellow"
            ),
            MemoryTheme<String>.Theme(
                name: "Animals",
                contents: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐽", "🐸", "🐵", "🐔", "🐧", "🐦", "🐥", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗", "🐴", "🦄", "🐳", "🐋", "🐙"],
                numberOfPairs: 30,
                color: "green"
            ),
            MemoryTheme<String>.Theme(
                name: "Helloween",
                contents: ["🕸", "🕷", "🦇", "🍭", "🍬", "👻", "☠️", "🎃"],
                color: "orange"
            ),
            MemoryTheme<String>.Theme(
                name: "Food",
                contents: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶", "🫑", "🌽", "🥕", "🫒", "🧄", "🧅", "🥔", "🍠"],
                color: "brown"
            ),
            MemoryTheme<String>.Theme(
                name: "Activity",
                contents: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🥊", "🤿", "🏹", "⛸", "🛼", "🥌"],
                color: "blue"
            )
        ]
    }
}
