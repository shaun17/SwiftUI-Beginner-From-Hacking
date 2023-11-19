//
//  Country+CoreDataProperties.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/19.
//
//

import Foundation
import CoreData


extension Country {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }
    
    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    
    public var wrappedFullName: String{
        fullName ?? "Unknow Country"
    }
    public var wrappedShortName: String{
        shortName ?? "Unknow Country"
    }
    
    public var candyArray:[Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted { item1, item2 in
            item1.wrappedName < item2.wrappedName
        }
    }

}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
