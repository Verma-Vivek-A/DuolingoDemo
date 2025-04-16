//
//  Constants.swift
//  Duolingo
//
//  Created by PC on 08/01/25.
//

import Foundation
import SwiftUI

class Constants {
    static let hearAboutUs: [String] = ["TikTok", "Friends", "News", "Facebook", "Google", "TV", "Youtube"]
    static let englishKnowledge: [String] = ["I'm new to English", "I know some common words", "I can have a basic conversation", "I can talk about various topics", "I can discuss most topics in detail"]
    static let learningEnglish: [String] = ["Just for fun", "Support my education", "Spend time productively", "Connect with people", "Boost my career", "Other"]
    static let dailyLearningGoal: [DailyLearningGoal] = [.init(time: "5 min / day", type: "Casual"), .init(time: "10 min / day", type: "Regular"), .init(time: "15 min / day", type: "Serious"), .init(time: "20 min / day", type: "Intense")]
    static let achieve: [Achieve] = [
        .init(title: "Converse with confidence", description: "Stress-free speaking and listening exercises"),
        .init(title: "Build up your vocabulary", description: "Common words and practical phrases"),
        .init(title: "Develop a learning habit", description: "Smart reminders, fun challenges, and more")
    ]
    
    struct DailyLearningGoal {
        let time: String
        let type: String
    }
    
    struct Achieve {
        let title: String
        let description: String
    }
}

struct Onboarding: Identifiable {
    let id: UUID = UUID()
    let message: AttributedString
    
    static let data: [Onboarding] = [
        Onboarding(message: "Hi there! I'm Duo!"),
        Onboarding(message: "Just 7 quick questions before \n we start first lesson!"),
        Onboarding(message: "What would you like \n to learn?"),
        Onboarding(message: "Get ready to join the 32 million \n people currently learning English \n with Duolingo"),
        Onboarding(message: "How did you hear \n about Duolingo?"),
        Onboarding(message: "How much english do \n you know?"),
        Onboarding(message: "Ok we will start fresh!"),
        Onboarding(message: "Why are you \n learning English?"),
        Onboarding(message: "Let's set up a \n learning routine!"),
        Onboarding(message: "What's your \n daily goal?"),
        Onboarding(message: Onboarding.getForegroundColoredString(for: "That's", with: .white) + Onboarding.getForegroundColoredString(for: " 25 words ", with: .purple) + Onboarding.getForegroundColoredString(for: "in \n your first week!", with: .white)),
        Onboarding(message: "I'll remind you to \n practice so it becomes \n a habit!"),
        Onboarding(message: "Here's what you can \n achieve in 3 months!"),
        Onboarding(message: "It can be hard to \n stay motivated..."),
        Onboarding(message: "...so Duolingo is designed to be \n fun like game!"),
        Onboarding(message: "Protip: After a lesson, write dowa as \n many phrases as you can remember \n from it."),
    ]
    
    static func getForegroundColoredString(for text: String, with color: Color) -> AttributedString {
        var attributedString = AttributedString(text)
        attributedString.foregroundColor = color
        return attributedString
    }
}

struct Syllabus {
    let id: UUID = UUID()
    let section: String
   
    let title: String
    let chapters: [String]
    
    let foregroundColor: Color
    let backgroundColor: Color
    
    static let data: [Syllabus] = [
        .init(section: "SECTION 1, UNIT 1", title: "Discuss traveling solo", chapters: [], foregroundColor: COLOR.primaryGreen, backgroundColor: COLOR.secondaryGreen),
        .init(section: "SECTION 1, UNIT 2", title: "Order food delivery", chapters: [], foregroundColor: COLOR.primaryBlue, backgroundColor: COLOR.secondaryBlue),
        .init(section: "SECTION 1, UNIT 3", title: "Describe a day in college", chapters: [], foregroundColor: COLOR.primaryOrange, backgroundColor: COLOR.secondaryOrange),
        .init(section: "SECTION 1, UNIT 4", title: "Discuss your work experience", chapters: [], foregroundColor: COLOR.primaryTeal, backgroundColor: COLOR.secondaryTeal),
        .init(section: "SECTION 1, UNIT 5", title: "Talk in an online meeting", chapters: [], foregroundColor: COLOR.primaryPink, backgroundColor: COLOR.secondaryPink)
    ]
}
