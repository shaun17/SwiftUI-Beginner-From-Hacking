//
//  ChallengeTwo.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/28.
//

import SwiftUI
struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.borderedProminent)
    }
}

struct ChallengeTwo: View {
    @State var current = 0
    @State var isWin = false
    @State var robotoutput = ""
    var items = ["✊", "👋", "✌️"]

    func compare(_ user1: String) {
        isWin = false
        var robot = Int.random(in: 0...2)
        robotoutput  = items[robot]
        switch robot {
        case 0:
            if user1 == "Paper" {
                isWin = true
            }
        
        case 1:
            if user1 == "Scissors" {
                isWin = true
            }
        case 2:
            if user1 == "Rock" {
                isWin = true
            }
        default: break
           
        }
        if isWin{
            current+=1
        }
    }
    
    var chose = Int.random(in: 0...3)
    var body: some View {
        VStack {
            Text("Your Score is \(current)")
            Text("Robot is \(robotoutput)")
            HStack {
                Button("👋") {
                    compare("Paper")
                }.modifier(ButtonStyle())
                Button("✌️") {
                    compare("Scissors")
                }.modifier(ButtonStyle())
                Button("✊") {
                    compare("Rock")
                }.modifier(ButtonStyle())
            }
        }
    }
}

struct ChallengeTwo_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeTwo()
    }
}
