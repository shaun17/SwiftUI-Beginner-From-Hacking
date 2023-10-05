//
//  QuizView.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/10/4.
//

import SwiftUI

struct QuizView: View {
    @State var symbol: String
    @State var cardinal: Int
    @State var questioCount: Int
    
    @State private var allAnswers = []
    
    @State private var multiplier = 0

    

    
    var body: some View {
        
        VStack{
            
            Text(symbol)
            Text(String(cardinal))
            Text(String(questioCount))
            
            
        }
        
        
       
    }
    
    func randomQuestion(){
        let multiplier = Int.random(in: 0...cardinal)
        
    }
    
    func allAnswer(_ symbol:String){
        allAnswers.append(operate(cardinal, multiplier, symbol))
        
        ForEach(0 ..< cardinal, id: \.self){
            var rand = Int.random(in: 0...cardinal)
            
            while multiplier == rand {
                rand = Int.random(in: 0...cardinal)
            }
            allAnswers.append(operate(cardinal, rand, symbol))

        }
       
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
    QuizView(symbol: "➕", cardinal: 3, questioCount: 4)
}
