import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var indexOfSeenCards: [Int]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
//        cards.shuffle()
        score = 0
        indexOfSeenCards = [Int]()
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
        
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                }
                if !cards[chosenIndex].isMatched {
                    if indexOfSeenCards.contains(chosenIndex) {
                        score -= 1
                    }
                    if indexOfSeenCards.contains(potentialMatchIndex) {
                        score -= 1
                    }
                }
                indexOfSeenCards.append(chosenIndex)
                indexOfSeenCards.append(potentialMatchIndex)
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }
    
//    mutating func choose(_ card: Card) {
//        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
//            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
//                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
//                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
//                        cards[chosenIndex].isMatched = true
//                        cards[potentialMatchIndex].isMatched = true
//                        score += 2
//                    }
//                    
//                    if indexOfSeenCards.contains(chosenIndex) && !cards[chosenIndex].isMatched {
//                        score -= 1
//                    } else {
//                        indexOfSeenCards.append(chosenIndex)
//                    }
//                    
//                } else {
//                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
//                }
//                cards[chosenIndex].isFaceUp = true
//            }
//        }
//    }

            
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
            
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content): \(isFaceUp ? "up" : "down") \(isMatched ? "mateched" : "needs a match")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
