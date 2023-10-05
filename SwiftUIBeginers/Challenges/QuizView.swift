//
//  QuizView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/4.
//

import SwiftUI

extension Button{
    func stylediy() -> some View{
        frame(width: 80, height: 80, alignment: .center)
            .font(.title)
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Circle())
        
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
    @State private var defaultAmount = 8
    @State private var isOver = false

    
    var body: some View {
        
        VStack{
            HStack{
                Text(String(cardinal))
                Text(symbol)
                Text("\(multiplier)")
                Image(systemName: "equal")
            }
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: .infinity))], content: {
                ForEach(allAnswers, id: \.self){ item in
                    Button("\(item)"){
                        checkAnswer(item)
                    }
                    .stylediy()
                    
                }
            })

            
        }.alert("Game Over", isPresented: $isOver, actions: {
            Button("New Game", role: .cancel) {
                dismiss()
            }
        })
        .onAppear(){
            newQuiz()
        }
        

       
    }
    
    func checkAnswer(_ item:Int){
        if item == result{
            if currentNum == questioCount {
                isOver = true
                return
            }
            newQuiz()
        }else{
            return
        }
    }
    
    
    func newQuiz(){
        currentNum += 1
        allAnswers.removeAll()
        multiplier = Int.random(in: 0..<cardinal)
        result = operate(cardinal, multiplier, symbol)
        allAnswers.append(result)
        while allAnswers.count < defaultAmount{
            var temp = Int.random(in: 0..<(cardinal*cardinal))
            while temp == multiplier || allAnswers.contains(temp) {
                temp = Int.random(in: 0..<cardinal)
            }
            allAnswers.append(temp)
        }
        allAnswers.shuffle()
    }
    
    
    
    func adddiy(_ one:Int, _ two: Int) -> Int{
        one+two
    }
    func subtractiondiy(_ one:Int, _ two: Int) -> Int{
        one-two
    }
    func multiplydiy(_ one:Int, _ two: Int) -> Int{
        one*two
    }
    func divisiondiy(_ one:Int, _ two: Int) -> Int{
        one/two
    }
    
    func operate(_ cardinal:Int, _ multiplier: Int,_ symbol2:String) -> Int{
        var result = 0
        switch symbol2{
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
    QuizView(symbol: "➕", cardinal: 9, questioCount:5)
}
