//
//  ChallengeTwo.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/9/28.
//

import SwiftUI
struct ChallengeTwo: View {
    @State private var  score = 0
    @State private var roundNum = 0
    @State private var loseNum = 0
    @State private var enqualNum = 0

    @State private var isWin = false
    @State private var robotoutput = ""
    @State private var roundEnd = false
    var items = ["✊", "👋", "✌️"]

    func compare(_ user1: String) {
        isWin = false
        roundNum += 1
        
        let robot = Int.random(in: 0...2)
        robotoutput = items[robot]
        
        if robotoutput == user1 {
            enqualNum += 1
            if roundNum >= 10 {
                roundEnd = true
            }
            return
        }
        
        switch robot {
        case 0:
            if user1 == "👋" {
                isWin = true
            }
        case 1:
            if user1 == "✌️" {
                isWin = true
            }
        case 2:
            if user1 == "✊" {
                isWin = true
            }
        default:
            break
        }
        if isWin {
            score += 1
        } else {
            loseNum += 1
        }
        
        if roundNum >= 10 {
            roundEnd = true
        }
       
        print(roundNum)
    }
    
    func reload() {
        score = 0
        roundNum = 0
        loseNum = 0
        enqualNum = 0
        roundEnd = false
    }
    
    struct ButtonStyle: ViewModifier {
        func body(content: Content) -> some View {
            content
                .buttonStyle(.borderedProminent)
        }
    }

    
    func getText() -> some View {
        VStack {
            Text("Win Score is \(self.score) \n Lose Score is \(loseNum) \n Enqual Score is \(enqualNum)")
        }
    }
    
   
    var chose = Int.random(in: 0...3)
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Text("Your Score is \(score)").font(.system(size: 50))
                Text("Robot is \(robotoutput)")
                HStack {
                    Button("👋") {
                        compare("👋")
                    }.modifier(ButtonStyle())
                        .alert("Game is Over", isPresented: $roundEnd, actions: {
                            Button("Cancel") {
                                reload()
                            }
                        }, message: {
                            getText()
                           
                        })
                        
                    Button("✌️") {
                        compare("✌️")
                    }.modifier(ButtonStyle())
                        .alert("Game is Over", isPresented: $roundEnd, actions: {
                            Button("Cancel") {
                                reload()
                            }
                        }, message: {
                            getText()
                        })
                    
                    Button("✊") {
                        compare("✊")
                    }.modifier(ButtonStyle())
                        .alert("Game is Over", isPresented: $roundEnd, actions: {
                            Button("Cancel") {
                                reload()
                            }
                        }, message: {
                            getText()
                        })
                }
            }
        }.ignoresSafeArea()
    }
}

struct ChallengeTwo_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeTwo()
    }
}
