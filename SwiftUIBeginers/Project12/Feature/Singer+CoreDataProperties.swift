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

}

extension Singer : Identifiable {

}
