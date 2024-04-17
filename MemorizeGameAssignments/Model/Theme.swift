import Foundation

struct Theme {
    let name: String
    let emojis: [String]
    let color: String
    let numberOfPairs: Int
}

extension Theme {
    static let food = Theme(name: "Food", emojis: ["🍏", "🍟", "🥑", "🍇", "🍰", "🥥", "🎂", "🍙", "🍥", "🥗", "🧃", "🍣"], color: "orangeModified", numberOfPairs: 12)
    static let faces = Theme(name: "Faces", emojis: ["😮‍💨", "😵‍💫", "🥱", "🥶", "🤭", "🤥", "🤓", "😃", "🥸", "🤨", "🤯", "😭"], color: "yellowModified", numberOfPairs: 12)
    static let vehicle = Theme(name: "Vehicle", emojis: ["🚕", "🚑", "✈️", "🚔", "🚀", "🚂", "🛵", "🚲", "🛳️", "🚜", "🚚", "🚒"], color: "blueModified", numberOfPairs: 12)
    
    private static var defaultThemes = [food, faces, vehicle]
    
    static var randomTheme: Theme {
        defaultThemes.randomElement()!
    }
    
    static func addTheme(theme: Theme) {
        defaultThemes.append(theme)
    }
}

