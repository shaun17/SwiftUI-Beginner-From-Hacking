//
//  Singer+CoreDataProperties.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String{
        firstName ?? "unknow"
    }
    
    var wrappedLastName: String{
        lastName ?? "unknow"
    }
    

}

extension Singer : Identifiable {

}
