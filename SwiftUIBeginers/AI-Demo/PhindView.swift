//
//  PhindView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/26.
//

import SwiftUI

struct PhindView: View {
    @State private var round = 1
    @State private var userChoice = ""
    @State private var computerChoice = ""
    @State private var result = ""
    @State private var score = 0
    @State private var showScoreAlert = false

    let choices = ["石头", "剪刀", "布"]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("当前是第 \(round) 局")
                    .font(.largeTitle)
                    .foregroundStyle(
                        LinearGradient(colors: [.red, .blue, .green, .yellow], startPoint: .leading, endPoint: .trailing)
                    )
                    .padding()

                Text("计算机选择：\(computerChoice)")
                    .font(.title)
                    .padding()

                HStack {
                    ForEach(choices, id: \.self) { choice in
                        Button(action: {
                            self.userChoice = choice
                            self.computerChoice = self.choices.randomElement() ?? ""
                            self.result = self.compareChoices()
                            self.updateScore()
                            if self.round == 1 || self.round == 5 {
                                self.showScoreAlert = true
                            }
                        }) {
                            Text(choice)
                                .font(.title)
                                .padding()
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.red, .blue, .green, .yellow]), startPoint: .leading, endPoint: .trailing)
                                )
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()

                Text("结果：\(result)")
                    .font(.title)
                    .padding()

                Text("比分：\(score)")
                    .font(.title)
                    .padding()
            }
        }
        .alert(isPresented: $showScoreAlert) {
            Alert(title: Text("比分"), message: Text("最后比分：\(score)"), dismissButton: .default(Text("确定")) {
                self.resetGame()
            })
        }
    }

    func compareChoices() -> String {
        if userChoice == computerChoice {
            return "平局"
        } else if (userChoice == "石头" && computerChoice == "剪刀") ||
            (userChoice == "剪刀" && computerChoice == "布") ||
            (userChoice == "布" && computerChoice == "石头")
        {
            return "胜利"
        } else {
            return "失败"
        }
    }

    func updateScore() {
        if result == "胜利" {
            score += 1
        }
        round += 1
        if round > 5 {
            round = 1
        }
    }

    func resetGame() {
        round = 1
        score = 0
    }
}

#Preview {
    PhindView()
}
