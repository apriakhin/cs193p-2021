//
//  ContentView.swift
//  Memorize
//
//  Created by Anton Priakhin on 18.12.2021.
//

import SwiftUI

struct ContentView: View {
    let themes = [
        Theme(
            title: "Vehicles",
            icon: "car",
            emojis: ["🚜", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚚", "🛻", "🚐"]
        ),
        Theme(
            title: "Clothes",
            icon: "tshirt",
            emojis: ["🧥", "🦺", "🥼", "👚", "👕", "👖", "🩳", "👗", "👔", "👘"]
        ),
        Theme(
            title: "Animals",
            icon: "pawprint",
            emojis: ["🐶", "🐱", "🐭", "🐰", "🦊", "🐻", "🐯", "🐵", "🐷", "🐮", "🦁"]
        ),
    ]
    
    @State var emojis = ["🚜", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚚", "🛻", "🚐"]
    @State var emojiCount = 4
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiCount)))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            bottomBar
        }
        .padding(.horizontal)
    }
    
    var bottomBar: some View {
        HStack {
            ForEach(themes, id: \.title) { theme in
                Button(action: {
                    emojis = theme.emojis.shuffled()
                    emojiCount = Int.random(in: 4...emojis.count)
                }) {
                    VStack {
                        Image(systemName: theme.icon)
                            .font(.largeTitle)
                        Text(theme.title)
                            .font(.caption)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        let count = CGFloat(cardCount < 4 ? 4 : cardCount)
        return (UIScreen.main.bounds.width) / count
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct Theme {
    let title: String
    let icon: String
    let emojis: [String]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
