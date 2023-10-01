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
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("entry your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        
                }
                
                ForEach(useWords, id: \.self){ word in
                    HStack{
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    
                }
            }
            .navigationTitle(titleWord)
            .navigationBarTitleDisplayMode(.inline)
            

        }
        
        .onSubmit() {
            saveword()
        }
        
    }
    func saveword(){
        let word =  newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        guard word.count > 0 else {return}
        withAnimation {
                    useWords.append(word)
        }
        newWord = ""
    }
}

#Preview {
    SwiftUIViewList()
}
