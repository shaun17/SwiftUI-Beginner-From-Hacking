//
//  Candy+CoreDataProperties.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/19.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName:String{
        name ?? "Unknow Candy"
    }

}

extension Candy : Identifiable {

}
