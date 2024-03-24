//
//  DataController.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/11.
//

import CoreData
import Foundation


class DataController: ObservableObject{
    
    let container = NSPersistentContainer(name: "Bookworm")
    let container2 = NSPersistentContainer(name: "CoreDataProject")

    init(){
        container.loadPersistentStores { descript, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        }
        container2.loadPersistentStores { descript, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
            self.container2.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        }
        
    }
}

