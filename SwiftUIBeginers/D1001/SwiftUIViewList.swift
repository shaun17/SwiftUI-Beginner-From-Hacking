//
//  SwiftUIViewList.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/1.
//

import SwiftUI

struct SwiftUIViewList: View {
    @State private var newWord = ""
    @State private var titleWord = ""
    @State private var useWords = [String]()
    
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    @State private var isError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("entry your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                ForEach(useWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
            }
            .navigationTitle(titleWord)
            .navigationBarTitleDisplayMode(.inline)
            .onSubmit {
                saveword()
            }
            .onAppear(perform: {
                startgrame()
            })
            .alert(errorTitle, isPresented: $isError) {
                Button("OK", role: .cancel, action: {})
            } message: {
                Text(errorMsg)
            }

            
        }
        
        

    }

    func saveword() {
        let word = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0 else { return }
        
        
        guard isOriginal(word: word) else{
            showError(title: "isOriginal", msg: "from isOriginal")
            return
        }
        
        
        guard isPossible(word: word) else{
            showError(title: "isPossible", msg: "from isPossible")
            return
        }
        
        
        guard isReal(word: word) else{
            showError(title: "isReal", msg: "from isReal")
            return
        }
        
        
        withAnimation {
            useWords.append(word)
        }
        newWord = ""
    }
    
    func startgrame(){
        if let startWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWrod = try? String(contentsOf: startWordUrl){
                let allWord = startWrod.components(separatedBy: "\n")
                titleWord = allWord.randomElement() ?? "default"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")

    }
    func showError(title:String, msg: String){
        errorTitle = title
        errorMsg = msg
        isError = true
        
    }
    func isOriginal(word: String) ->Bool {
        !useWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var temp = titleWord
        for letter in word{
            if let pos = temp.firstIndex(of: letter){
                temp.remove(at: pos)
                print(temp)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let uiTextChecker = UITextChecker()
        let nsrange = NSRange(location: 0, length: word.utf16.count)
        let misspell = uiTextChecker.rangeOfMisspelledWord(in: word, range: nsrange, startingAt: 0, wrap: false, language: "en")
        return misspell.location == NSNotFound
    }
    

}

#Preview {
    SwiftUIViewList()
}
