//
//  CoreDataManager.swift
//  ItunesSearch
//
//  Created by Eliric on 11/13/20.
//

import Foundation
import CoreData
import UIKit

struct CoreDataManager<T: NSManagedObject> : Repository{
    
    typealias Entity = T
    
    //MARK: - Core Data

    private var managedObjectContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func fetchData<T:NSManagedObject>(entity: T.Type)->[T] {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        do{
            let result = try managedObjectContext.fetch(fetchRequest)
            return result
        }catch {
            return []
        }
    }
    
    func create() -> Result<Entity, Error> {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        return .success(managedObject)
    }
    
    func delete(entity:String)-> Result<Bool, Error> {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do{
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
            return .success(true)
        }
        catch{
            return .failure(error)
        }
    }
}


protocol Repository {
    /// The entity managed by the repository.
    associatedtype Entity

//    /// Gets an array of entities.
//    /// - Parameters:
    func fetchData<T:NSManagedObject>(entity: T.Type)->[T]

    /// Creates an entity.
    func create() -> Result<Entity, Error>

    /// Deletes an entity.
    /// - Parameter entity: The entity to be deleted.
//    func delete(entity: Entity) -> Result<Bool, Error>
    func delete(entity:String)-> Result<Bool, Error>
}

/// Enum for CoreData related errors
enum CoreDataError: Error {
    case invalidManagedObjectType
}
