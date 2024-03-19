//
//  Pro9Part1.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2024/3/18.
//

import SwiftUI

struct Pro9Part1: View {
    @State private var path = [Int]()
    @State private var path2 = NavigationPath()
    var body: some View {
        // 主页面加载，就会渲染子页面
//        NavigationStack {
//            NavigationLink("Tap Me") {
//                DetailView(number: 556)
//            }
//        }
        
        // 使用的时候才会渲染子页面
//        NavigationStack{
//            List(0..<100){
//                NavigationLink("select \($0)",value: $0)
//            }
//            .navigationDestination(for: Int.self) { selectino in
//                DetailView(number: selectino)
//                
//            }
//        }
       
        // 支持多种类型的子页面渲染
        // 但是path存在多个值的时候， 子页面按照集合顺序同时渲染多个页面
//        Button("Show 32") {
//            path = [32]
//        }
//        
//        Button("Show 64") {
//            path.append(64)
//        }
//        Button("Show 32 then 64") {
//            path = [32, 64]
//        }
//
//        NavigationStack(path: $path, root: {
//            Section {
//                VStack {}
//                    .navigationDestination(for: Int.self) { selection in
//                        DetailView(number: selection)
//                    }
//            }
//        })
        
        
        // 支持多种类型的页面，使用navigation的modify判断
        // link中的文本只是用于展示，具体页面信息看modify中的数据
//        NavigationStack{
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Select Number: \(i)", value: i)
//                }
//                ForEach(0..<5) { i in
//                    NavigationLink("Select String: \(i)", value: String(i))
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected the number \(selection)")
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected the string \(selection)")
//            }
//        }
        
        
        NavigationStack(path: $path2) {
            List {
                ForEach(0..<20){ number in
                    Button("Push \(number)") {
                        path2.append(number)
                    }
                }
               
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
            .toolbar {
                Button("Push 556") {
                    path2.append(556)
                }

                Button("Push Hello") {
                    path2.append("Hello")
                }
            }
        }
    }
}

struct DetailView: View {
    var number: Int

    var body: some View {
        Text("Detail View \(number)")
    }

    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}


#Preview {
    Pro9Part1()
}
