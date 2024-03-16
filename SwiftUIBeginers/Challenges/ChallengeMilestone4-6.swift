//
//  Challeng4-6.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/16.
//

import SwiftUI

struct Challeng4_6: View {
    @State private var multiplicationRange: Int = 5
    @State private var numberOfQuestionsIndex: Int = 0
    let numberOfQuestionsOptions = [5, 10, 15]
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("乘法测试")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    CardView {
                        Stepper(value: $multiplicationRange, in: 2...12) {
                            Text("选择范围: 2 到 \(multiplicationRange)")
                                .foregroundColor(.black)
                        }
                    }
                    
                    CardView {
                        Picker("题目数量", selection: $numberOfQuestionsIndex) {
                            ForEach(0..<numberOfQuestionsOptions.count, id: \.self) {
                                Text("\(self.numberOfQuestionsOptions[$0]) 题")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    NavigationLink(destination: QuizzView(multiplicationRange: multiplicationRange, numberOfQuestions: numberOfQuestionsOptions[numberOfQuestionsIndex] + 1)) {
                        Text("开始")
                            .foregroundColor(.white)
                            .padding()
                            .background(Capsule().fill(Color.green))
                    }
                }
                .padding()
            }
        }
    }
}

 struct CardView<Content: View>: View {
     let content: Content
     
     init(@ViewBuilder content: () -> Content) {
         self.content = content()
     }
     
     var body: some View {
         VStack {
             content
         }
         .padding()
         .background(Color.white.opacity(0.9))
         .cornerRadius(10)
         .shadow(radius: 5)
     }
 }

 // QuizView
 struct QuizzView: View {
     var multiplicationRange: Int
        var numberOfQuestions: Int
        @State private var questions: [(question: String, answer: Int)] = []
        @State private var currentQuestion = 0
        @State private var answerOptions: [Int] = []
        @State private var selectedAnswer: Int? = nil
        @State private var showAnswer = false
        @State private var answerCorrect = false
        @State private var correctAnswers = 0
        @State private var showAlert = false

     @Environment(\.presentationMode) var presentationMode


        func generateQuestions() {
            questions = []
            for _ in 0..<numberOfQuestions {
                let num1 = Int.random(in: 2...multiplicationRange)
                let num2 = Int.random(in: 2...multiplicationRange)
                let question = "\(num1) x \(num2) = ?"
                let answer = num1 * num2
                questions.append((question, answer))
            }
            nextQuestion()
        }
        
        func nextQuestion() {
            print(currentQuestion,questions.count)
            if currentQuestion >= questions.count-1 {
                // 异步更新状态，避免在视图更新过程中直接修改状态
//                DispatchQueue.main.async {
                    self.showAlert = true
//                }
                return
            }
            let correctAnswer = questions[currentQuestion].answer
            answerOptions = [correctAnswer]
            while answerOptions.count < 6 {
                let option = Int.random(in: 4...multiplicationRange*12)
                if !answerOptions.contains(option) {
                    answerOptions.append(option)
                }
            }
            answerOptions.shuffle()
            showAnswer = false
            
            
        }
        
        var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text(questions.isEmpty ? "加载中..." : questions[currentQuestion].question)
                        .font(.largeTitle)
                        .foregroundColor(showAnswer && !answerCorrect ? .red : .white)
                        .scaleEffect(showAnswer && !answerCorrect ? 1.2 : 1)
                        .animation(.easeInOut, value: showAnswer)
                    
                    ForEach(0..<6) { index in
                        if index < answerOptions.count {
                            Button(action: {
                                selectedAnswer = answerOptions[index]
                                showAnswer = true
                                answerCorrect = answerOptions[index] == questions[currentQuestion].answer
                                if answerCorrect {
                                    correctAnswers += 1
                                    questions[currentQuestion].question = questions[currentQuestion].question.replacingOccurrences(of: "?", with: "\(answerOptions[index])")
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    currentQuestion += 1
                                    nextQuestion()
                                }
                            }) {
                                Text("\(answerOptions[index])")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("测试完成"),
                        message: Text("恭喜完成测试，本次测试正确\(correctAnswers)，错误\(numberOfQuestions - correctAnswers)，再接再厉"),
                        dismissButton: .default(Text("返回")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
            }
            .onAppear(perform: generateQuestions)
        }
    }

#Preview {
    Challeng4_6()
}
