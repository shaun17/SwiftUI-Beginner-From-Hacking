//
//  SwiftUIViewDelete.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/6.
//

import SwiftUI

struct UserName: Codable{
     var firstName: String
     var lastName: String
}

struct SwiftUIViewDelete: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var user = UserName(firstName: "Ros", lastName: "Casy")
    
    @AppStorage("tapCount") private var tapCount = 0
    
    var body: some View {
        NavigationView{
            
            VStack {
                
                HStack{
                    Button("save user"){
                        if let data = try? JSONEncoder().encode(user) {
//                            if let json = String(data: data, encoding: .utf8) {
//                                print(json)
//                                
//                                UserDefaults.standard.set(json, forKey:"UserName")
//                            }
                            print(user)
                            let username = UserDefaults.standard.string(forKey: "UserName")!
                            
                            if let data2 = try? JSONDecoder().decode(UserName.self, from: username.data(using: .utf8)!) {
                                print(data2)
                            }
                        }
                    }
                    
                    Text("\(UserDefaults.standard.string(forKey: "UserName") ?? "default")")
                }
                
                Button("tap me \(tapCount)"){
                    tapCount += 1
                }
                
                
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("delete()")
            .toolbar{
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    SwiftUIViewDelete()
}
