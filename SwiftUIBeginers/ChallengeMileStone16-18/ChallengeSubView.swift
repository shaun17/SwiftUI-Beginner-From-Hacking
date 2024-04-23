//
//  ChallengeSubView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/4/23.
//

import Combine
import SwiftUI

struct ChallengeSubView: View {
    let sum: Int
    let face: Int
    @State private var currentColumn = 0
    @State var numbers = [String]()

    @State private var isButtonDisabled = false

    @State private var temporaryNumber = ""
    @State private var timer: Timer.TimerPublisher = Timer.publish(every: 0.1, on: .main, in: .common)
    @State private var timerCancellable: Cancellable?

    init(sum: Int, face: Int) {
        self.sum = sum
        self.face = face
        _numbers = State(initialValue: Array(repeating: "", count: sum))
    }

    var body: some View {
        HStack {
            ForEach(0 ..< sum, id: \.self) { index in
                VStack {
                    Text("Round \(index + 1)")
                        .font(.headline)
                    Text(numbers[index])
                        .font(.title)
                        .frame(width: 60, height: 60)
                        .border(Color.gray)
                }
            }
        }
        .padding()

        VStack {
            Text(temporaryNumber)
                .font(.largeTitle)
                .padding()
        }

        // 添加按钮
        Button("Start") {
            startRandomNumberGeneration()
        }
        .padding()
        .background(isButtonDisabled ? Color.gray : Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .disabled(isButtonDisabled) // 使用状态变量控制按钮是否禁用
    }

    func startRandomNumberGeneration() {
        isButtonDisabled = true // 禁用按钮
        temporaryNumber = "" // 清空临时数字

        // 启动定时器
        timerCancellable = timer.autoconnect().sink { _ in
            temporaryNumber = "\(Int.random(in: 1 ... face))"
        }

        // 延时后停止定时器并生成最终随机数
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            timerCancellable?.cancel() // 停止定时器
            generateRandomNumber(temporaryNumber: temporaryNumber)
            isButtonDisabled = false // 启用按钮
        }
    }

    func generateRandomNumber(temporaryNumber: String) {
        if currentColumn < 5 {
//            let randomNumber = Int.random(in: 1 ... face)
            numbers[currentColumn] = "\(temporaryNumber)"
            currentColumn += 1
        }
    }
}

#Preview {
    ChallengeSubView(sum: 3, face: 6)
}
