//
//  SwiftUIView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/26.
//
import SwiftUI

enum GameOption: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct SwiftUIView: View {
    let options = GameOption.allCases
    @State private var computerChoice: GameOption?
    @State private var currentRound = 1
    @State private var playerScore = 0
    @State private var computerScore = 0
    @State private var showingScore = false
    @State private var gameMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Round \(currentRound) of 5")
                .font(.largeTitle)
                .foregroundColor(.orange)
            
            if let computerChoice = computerChoice {
                Text("Computer chose: \(computerChoice.rawValue)")
                    .font(.title2)
                    .foregroundColor(.purple)
            } else {
                Text("Make your choice")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    self.buttonTapped(option)
                }) {
                    Text(option.rawValue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Text(gameMessage)
                .font(.title)
                .foregroundColor(.green)
        }
        .padding()
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Game Over"), message: Text("Final round: \(gameMessage)\nYour score: \(playerScore)\nComputer's score: \(computerScore)"), dismissButton: .default(Text("Restart")) {
                self.restartGame()
            })
        }
    }
    
    func buttonTapped(_ playerChoice: GameOption) {
        computerChoice = options.randomElement()!
        let result = checkWin(player: playerChoice, computer: computerChoice!)
        
        switch result {
        case "Win":
            playerScore += 1
            gameMessage = "You Win!"
        case "Lose":
            computerScore += 1
            gameMessage = "You Lose!"
        default:
            gameMessage = "It's a draw!"
        }
        
        if currentRound == 5 {
            showingScore = true
        } else {
            currentRound += 1
        }
    }
    
    func checkWin(player: GameOption, computer: GameOption) -> String {
        if player == computer {
            return "Draw"
        }
        
        switch player {
        case .rock:
            return computer == .scissors ? "Win" : "Lose"
        case .paper:
            return computer == .rock ? "Win" : "Lose"
        case .scissors:
            return computer == .paper ? "Win" : "Lose"
        }
    }
    
    func restartGame() {
        currentRound = 1
        playerScore = 0
        computerScore = 0
        computerChoice = nil
        gameMessage = ""
    }
}

#Preview {
    SwiftUIView()
}
