//
//  LastAccessedAlbum+CoreDataProperties.swift
//  ItunesSearch
//
//  Created by Eliric on 11/13/20.
//
//

import Foundation
import CoreData


extension LastAccessedAlbum {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastAccessedAlbum> {
        return NSFetchRequest<LastAccessedAlbum>(entityName: "LastAccessedAlbum")
    }

    @NSManaged public var artworkUrl100: String?
    @NSManaged public var date: Date?
    @NSManaged public var longDescription: String?
    @NSManaged public var primaryGenreName: String?
    @NSManaged public var trackName: String?
    @NSManaged public var trackPrice: Double

}

extension LastAccessedAlbum : Identifiable {

}
