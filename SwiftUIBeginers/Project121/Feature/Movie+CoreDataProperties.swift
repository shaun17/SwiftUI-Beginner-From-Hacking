//
//  Movie+CoreDataProperties.swift
//  SwiftUIBeginers
//
//  Created by shaun on 2023/11/18.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String
    @NSManaged public var year: Int16
    @NSManaged public var director: String

}

extension Movie : Identifiable {

}
