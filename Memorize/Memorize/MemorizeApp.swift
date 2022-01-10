//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Anton Priakhin on 18.12.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
