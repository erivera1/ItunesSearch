//
//  Records+CoreDataProperties.swift
//  ItunesSearch
//
//  Created by Eliric on 11/15/20.
//
//

import Foundation
import CoreData


extension Records {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Records> {
        return NSFetchRequest<Records>(entityName: "Records")
    }

    @NSManaged public var artworkUrl100: String?
    @NSManaged public var date: Date?
    @NSManaged public var longDescription: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var trackName: String?
    @NSManaged public var trackPrice: Double

}

extension Records : Identifiable {

}
