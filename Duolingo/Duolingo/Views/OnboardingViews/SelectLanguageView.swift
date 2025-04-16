//
//  SelectLanguageView.swift
//  Duolingo
//
//  Created by PC on 08/01/25.
//

import SwiftUI 

struct SelectLanguageView: View {
    
    struct LearnLanguage {
        let id: UUID = UUID()
        let title: String
        let languages: [Language]
        
        struct Language {
            let id: UUID = UUID()
            let flag: String
            let name: String
        }
    }
    
    @State private var selectedId: UUID?
    private let data: [LearnLanguage] = [
        .init(title: "For Hindi speakers", languages: [.init(flag: "🇺🇸", name: "England"), .init(flag: "🇩🇿", name: "Spanish")]),
        .init(title: "For English speakers", languages: [.init(flag: "🇮🇳", name: "Hindi"), .init(flag: "🇬🇧", name: "Intermediate English"), .init(flag: "🇦🇱", name: "Korean")])
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.data, id: \.id) { item in
                    Text(item.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    ForEach(item.languages, id: \.id) { language in
                        Button {
                            self.selectedId = language.id
                        } label: {
                            HStack {
                                Text(language.flag)
                                    .font(.largeTitle)
                                Text(language.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(self.selectedId == language.id ? COLOR.primaryBlue : .white)
                                Spacer()
                            }
                            .padding(10)
                        }
                        .buttonStyle(DepthButtonStyle(foregroundColor: .black, backgroundColor: self.selectedId == language.id ? COLOR.primaryBlue : COLOR.gray, cornerRadius: 16, lineWidth: 1))
                        .padding(.vertical, 5)
                    }
                }
            }
        }
    }
}

#Preview {
    SelectLanguageView()
}
