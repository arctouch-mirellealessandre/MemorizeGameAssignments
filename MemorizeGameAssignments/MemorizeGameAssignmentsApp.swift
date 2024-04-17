import SwiftUI

@main
struct MemorizeAssignmentsApp: App {
    @StateObject var game = EmojiMemoryGame(theme: Theme.randomTheme)
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
