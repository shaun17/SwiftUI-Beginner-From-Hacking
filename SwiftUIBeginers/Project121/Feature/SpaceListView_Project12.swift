//
//  SpaceListView_Project12.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//
import CoreData
import SwiftUI

struct SpaceListView_Project12: View {
    

    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var spwaves: FetchedResults<Space>
    
    var body: some View {
        VStack{
            List{
                ForEach(spwaves, id: \.self){ space in
                    Section{

                        Text(space.universe ?? "unknow")
                        Text(space.name ?? "unknow")
                    }
                }
            }
        
            Button("Add Examples") {
                do{
                    let sp1 = Space(context: moc)
                    sp1.name = "Enterprise"
                    sp1.universe = "Star Trek"
                    
                    let sp2 = Space(context: moc)
                    sp2.name = "Defiant"
                    sp2.universe = "Star Trek"
                    
                    let sp3 = Space(context: moc)
                    sp3.name = "Millennium Falcon"
                    sp3.universe = "Star Wars"
                    
                    let sp4 = Space(context: moc)
                    sp4.name = "Executor"
                    sp4.universe = "Star Wars"
                    
                    try moc.save()
                } catch {
                    print("Failed to save managed object context: \(error)")
                }
           }
        }
    }
}

struct SpaceListView_PreView: PreviewProvider {
    static let  dataController = DataController()
    static var previews: some View {
        // 在预览中创建自己的上下文
        let spaceListView = SpaceListView_Project12()
            .environment(\.managedObjectContext,dataController.container2.viewContext)
        return spaceListView
    }
}
