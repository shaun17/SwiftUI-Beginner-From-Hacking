//
//  Pro5Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/13.
// List, Bundle, UITextChecker

import SwiftUI

struct Pro5Part1: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    let input = "a b c"


    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }

     
        ForEach(people, id: \.self){
            Text("Dynamic row \($0)")

        }
        .listStyle(.grouped)
        
        List(0 ..< 5) {
            Text("Dynamic row \($0)")
        }
        .listStyle(.grouped)

        
        if let fileUrl = Bundle.main.url(forResource: "", withExtension: "txt"){

        }
        
        let letters = input.components(separatedBy: " ")
        let letter = letters.randomElement()

        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Button("check", action: check)
        
    }
    
    func check(){
        let word = "swiqft"

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
       print(allGood)
    }
}

#Preview {
    Pro5Part1()
}
