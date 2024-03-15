//
//  Pro5Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/14.
//

import SwiftUI

struct Pro5Part2: View {
    @State private var useWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(useWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: {
                startGame()
            })
            .alert(errorTitle, isPresented: $showingError) {
                Button("Next", action: startGame)
                Button("OK"){}

            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let input = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if input.count < 1 { return }
        
        guard isOriginal(word: input) else {
            wordError(title: "Word used already", message: "Be more original")
                return
        }
        guard isPossible(word: input) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")

            return
        }
        
        guard isReal(word: input) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")

            return
        }
        withAnimation {
            useWords.insert(input, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        if let start = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: start) {
                let words = startWords.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? "N/A"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !useWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var temp = rootWord
        for letter in word {
            if let pos = temp.firstIndex(of: letter) {
                temp.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let chekcer = UITextChecker()
        let range = NSRange(location: 0, length: word.count)
        let misspell = chekcer.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspell.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    Pro5Part2()
}
