//
//  ChallengeThree.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/4.
//

import SwiftUI

struct ChallengeThree: View {
    @State private var symbols = ["➕", "➖", "✖️", "➗"]
    @State private var symbolSelect = "➕"

    @State private var numbs = Array(5 ..< 13)
    @State private var numSelect = 0

    @State private var questionCounts = [5, 10, 15, 20]
    @State private var selectQuestionCount = 0

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("chose element") {
                        VStack {
                            Picker("基数范围请选择", selection: $numSelect) {
                                ForEach(0 ..< numbs.count, id: \.self) { index in
                                    Text("\(numbs[index])")
                                }
                            }
                            Picker(selection: $symbolSelect) {
                                ForEach(symbols, id: \.self) { item in
                                    Text(item)
                                }
                            } label: {
                                Text("运算符")
                            }

                            Picker(selection: $selectQuestionCount) {
                                ForEach(0 ..< questionCounts.count, id: \.self) { index in
                                    Text(String(questionCounts[index]))
                                }
                            } label: {
                                Text("题目数")
                            }
                        }
                    }
                }

                NavigationLink(destination: QuizView(symbol: symbolSelect, cardinal: numbs[numSelect], questioCount: questionCounts[selectQuestionCount])) {
                    Text("Let's Go")
                }
            }
        }
    }
}

#Preview {
    ChallengeThree()
}
