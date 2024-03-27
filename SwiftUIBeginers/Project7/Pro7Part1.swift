//
//  Pro7Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/16.
//

import Observation
import SwiftUI

@Observable
class UserPro7 {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

struct UserPro7V2: Codable{
    let firstName: String
    let lastName: String
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss

    let name: String
    var body: some View {
        Text("Second View, Hello \(name)")
        Button("dismiss") {
            dismiss()
        }
    }
}

struct Pro7Part1: View {
    @State private var user = UserPro7()
    @State private var user2 = UserPro7V2(firstName: "Tomy", lastName: "Jacson")
    @State private var showingSheet = false

    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    @AppStorage("tapCount") private var tapCount = 0

    var body: some View {
        NavigationStack{
            VStack {
                Form {
                    Text("Your name is \(user.firstName) \(user.lastName).")
                    
                    TextField("First name", text: $user.firstName)
                    TextField("Last name", text: $user.lastName)
                }
                Section{

                    Button("Tap count: \(tapCount)") {
                        tapCount += 1
                      }
                }
                
                Section{
                    Button("save User"){
                        let encoder = JSONEncoder()
                        if let data = try? encoder.encode(user2){
                            UserDefaults.standard.setValue(data, forKey: "UserData")
                        }
                        
                    }
                    
                    Button("get User"){
                        if let data = UserDefaults.standard.data(forKey: "UserData"){
                            let decoder = JSONDecoder()
                            if let user = try? decoder.decode(UserPro7V2.self, from: data){
                                print(user)
                            }
                        }
                       
                        
                    }
                }
                
                List{
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: { indexSet in
                        removeRows(at: indexSet)
                    })
                    
                    Button("Add Number") {
                        numbers.append(currentNumber)
                        currentNumber += 1
                    }
                }
                
                Section {
                    Button("Show Sheet") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        SecondView(name: "will")
                    }
                }
            } .toolbar(content: {
                EditButton()
            })
        }
       
    }
    
    func removeRows(at offset: IndexSet){
        numbers.remove(atOffsets: offset)
    }
}

#Preview {
    Pro7Part1()
}
