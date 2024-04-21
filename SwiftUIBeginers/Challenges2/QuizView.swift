//
//  QuizView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/4.
//

import SwiftUI

extension Button {
    func styleCircle() -> some View {
        frame(width: 80, height: 80, alignment: .center)
            .font(.title)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Circle())
    }

    func styleRactangle(_ color: Color) -> some View {
        frame(width: 40, height: 60, alignment: .center)
            .font(.title)
            .foregroundColor(.white)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 8)) // 设置矩形圆角
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 4) // 添加矩形边框
            )
    }
}

struct QuizView: View {
    @Environment(\.dismiss) var dismiss

    // 符号
    @State var symbol: String
    // 基数
    @State var cardinal: Int
    // 答题数量
    @State var questioCount: Int
    // 轮次
    @State var currentNum = 0
    // 自动生成的答案数量
    @State private var allAnswers = [Int]()
    // 被乘数
    @State private var multiplier = 0
    // 被乘数
    @State private var result = 0
    @State private var tempResult = 0

    @State private var defaultAmount = 8
    @State private var isOver = false

    @State private var isHiden = true
    @State private var goodjob = true

    var body: some View {
        VStack {
            ProgressView("Question #\(currentNum) out of \(questioCount)", value: Double(currentNum), total: Double(questioCount))
                .padding(.top, 50)
                .padding(.horizontal)

            Spacer()

            HStack {
                Button(String(cardinal)) {}
                    .styleRactangle(.purple)
                Text(symbol).font(.title)
                Button(String(multiplier)) {}
                    .styleRactangle(.purple)
                Image(systemName: "equal")
                    .font(.title)
                    .bold()

                if isHiden {
                    withAnimation(.easeIn) {
                        Image(systemName: "questionmark")
                            .font(.title)
                            .bold()
                    }

                } else {
                    if goodjob {
                        Button(String(tempResult)) {}
                            .styleRactangle(.green)
                            .animation(.easeOut(duration: 0.75), value: isHiden)
                    } else {
                        Button(String(tempResult)) {}
                            .styleRactangle(.red)
                            .animation(.easeOut(duration: 0.75), value: isHiden)
                    }
                }
            }
            Spacer()

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: .infinity))], content: {
                ForEach(allAnswers, id: \.self) { item in
                    Button("\(item)") {
                        checkAnswer(item)
                    }
                    .styleCircle()
                }
            })
            Spacer()

        }.alert("Game Over", isPresented: $isOver, actions: {
            Button("New Game", role: .cancel) {
                dismiss()
            }
        })
        .onAppear {
            withAnimation {
                newQuiz()
            }
        }
    }

    func checkAnswer(_ item: Int) {
        tempResult = item
        if item == result {
            withAnimation(.easeInOut(duration: 0.5)) {
                isHiden = false
                goodjob = true
            }

            if currentNum == questioCount {
                isOver = true
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                newQuiz()
            }
        } else {
            withAnimation(.easeInOut(duration: 0.5)) {
                isHiden = false
                goodjob = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeOut) {
                    isHiden = true
                    goodjob = true
                }
            }
            return
        }
    }

    func newQuiz() {
        withAnimation {
            isHiden = true
        }

        createQuiz()
    }

    func createQuiz() {
        currentNum += 1
        allAnswers.removeAll()
        multiplier = Int.random(in: 0 ..< cardinal)
        result = operate(cardinal, multiplier, symbol)
        tempResult = result
        allAnswers.append(result)
        while allAnswers.count < defaultAmount {
            var temp = Int.random(in: 0 ..< (cardinal * cardinal))
            while temp == multiplier || allAnswers.contains(temp) {
                temp = Int.random(in: 0 ..< cardinal)
            }
            allAnswers.append(temp)
        }
        allAnswers.shuffle()
    }

    func adddiy(_ one: Int, _ two: Int) -> Int {
        one + two
    }

    func subtractiondiy(_ one: Int, _ two: Int) -> Int {
        one - two
    }

    func multiplydiy(_ one: Int, _ two: Int) -> Int {
        one * two
    }

    func divisiondiy(_ one: Int, _ two: Int) -> Int {
        one / two
    }

    func operate(_ cardinal: Int, _ multiplier: Int, _ symbol2: String) -> Int {
        var result = 0
        switch symbol2 {
        case "➕":
            result = adddiy(cardinal, multiplier)
        case "➖":
            result = subtractiondiy(cardinal, multiplier)
        case "✖️":
            result = multiplydiy(cardinal, multiplier)

        case "➗":
            result = divisiondiy(cardinal, multiplier)

        default:
            break
        }
        return result
    }
}

#Preview {
    QuizView(symbol: "➕", cardinal: 9, questioCount: 5)
}
