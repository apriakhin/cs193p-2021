//
//  MemoryTheme.swift
//  Memorize
//
//  Created by Anton Priakhin on 09.01.2022.
//

import Foundation

struct MemoryTheme<ThemeContent> {
    private let themes: Array<Theme>
    private var chosenTheme: Theme
    
    var name: String {
        chosenTheme.name
    }
    
    var contents: [ThemeContent] {
        chosenTheme.contents
    }
    
    var numberOfPairs: Int {
        chosenTheme.numberOfPairs
    }
    
    var color: String {
        chosenTheme.color
    }
    
    init(themes: Array<Theme>) {
        guard !themes.isEmpty, let chosenTheme = themes.randomElement() else {
            fatalError("Array of themes must be not empty")
        }
        
        self.themes = themes
        self.chosenTheme = chosenTheme
    }
    
    struct Theme {
        let name: String
        let contents: [ThemeContent]
        let numberOfPairs: Int
        let color: String
        
        init(
            name: String,
            contents: [ThemeContent],
            color: String
        ) {
            self.init(
                name: name,
                contents: contents,
                numberOfPairs: contents.count,
                color: color
            )
        }
        
        init(
            name: String,
            contents: [ThemeContent],
            numberOfPairs: Int,
            color: String
        ) {
            self.name = name
            self.contents = contents
            self.numberOfPairs = numberOfPairs
            self.color = color
        }
    }
}
