//
//  Pro5Part2.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/14.
//

import SwiftUI

struct Challenge3: View {
    @State private var useWords = [String]()
    @State private var mapping = [String: Int]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var times = 0
    @State private var needReload = false
    
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
                            Spacer()
                            Text("try tims: \(mapping[word] ?? 0)")
                            
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
            .toolbar(content: {
                Button("ReStart",action: startGame)
            })
        }
    }
    
    func addNewWord() {
        
            times += 1
       
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
        
        if input.count < 3 {
            wordError(title: "Too short", message: "Word need more than three letters")
            return
        }
        if input != rootWord {
            wordError(title: "Incorrect", message: "Word is incorrect")
            return
        }
        
        withAnimation {
            
            useWords.insert(input, at: 0)
            mapping[input] = times
            
        }
        
        newWord = ""
        startGame()
    }
    
    func startGame() {
        if let start = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: start) {
                let words = startWords.components(separatedBy: "\n")
                rootWord = words.randomElement() ?? "N/A"
                times = 0
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
    Challenge3()
}
