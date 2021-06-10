//
//  Emoji.swift
//  TableView
//
//  Created by Gianluca Orpello on 10/06/21.
//

import Foundation

struct Emoji: Codable {
    
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var archiveURL: URL {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentURL.appendingPathComponent("EmojiList").appendingPathExtension("plist")
        
        return archiveURL
    }
    
    // API Saving Locally
    
    static func saveToFile(_ emojis: [Emoji]) {
        let encoder = PropertyListEncoder()
        do {
            let encodedEmoji = try encoder.encode(emojis)
            try encodedEmoji.write(to: Emoji.archiveURL)
        } catch {
            print("Can't Save The Emoji List! - \(error)")
        }
    }
    
    static func loadFromFile() -> [Emoji]? {
        guard let emojiData = try? Data(contentsOf: Emoji.archiveURL) else { return nil }
        
        do {
            
            let decoder = PropertyListDecoder()
            let decodedEmoji = try decoder.decode([Emoji].self, from: emojiData)
            
            return decodedEmoji
            
        } catch {
            print("Can't Load The Emoji List! - \(error)")
            return nil
        }
    }
    
    // Api for web post request
        
    static var semplesEmojis: [Emoji] = [
        Emoji(symbol: "😀",
              name: "Grinning Face",
              description: "A typical smiley face.",
              usage: "happiness"),
        Emoji(symbol: "😕",
              name: "Confused Face",
              description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",
              description: "A smiley face with hearts for eyes.",
              usage: "love of something; attractive"),
        Emoji(symbol: "🧑‍💻", name: "Developer",
              description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
        Emoji(symbol: "🐢", name: "Turtle", description:
                "A cute turtle.", usage: "something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description:
                "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",
              description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
              description: "Three colored books stacked on each other.",
              usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",
              description: "A black-and-white checkered flag.", usage:
                "completion")
    ]
}
