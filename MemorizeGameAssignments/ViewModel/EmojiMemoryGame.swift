import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>

    var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        model = Self.createMemoryGame(with: theme)
    }
    
    var themeName: String {
        return theme.name
    }
    
    var cardsColor: Color {
        return Color(theme.color)
    }
            
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
                return theme.emojis[pairIndex]
        }
    }
            
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
            
//MARK: - Intents

    func newGame() {
        theme = Theme.randomTheme
        model = Self.createMemoryGame(with: theme)
    }
            
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
