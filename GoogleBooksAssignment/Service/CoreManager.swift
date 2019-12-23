//
//  CoreManager.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import CoreData

final class CoreManager
{
    static let shared = CoreManager()
    
    private init(){}
    
    var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoogleBooksAssignment")
        
        container.loadPersistentStores{
            (storeDescrip, err) in
            if let error = err{
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    //MARK: Load
    func load() -> [Book]
    {
        let fetch = NSFetchRequest<CoreBook>(entityName: "CoreBook")
        
        var books = [Book]()
        
        do{
            let coreBooks = try context.fetch(fetch)
            
            for core in coreBooks{
                let book = Book(core)
                books.append(book)
            }
            
        }catch{
            print("Could Not Fetch Books \(error.localizedDescription)")
        }
        
        return books
    }
    
    //MARK: Save
    func save(_ book: Book)
    {
        guard let entity = NSEntityDescription.entity(forEntityName: "CoreBook", in: context) else {return }
        let coreBook = CoreBook(entity: entity, insertInto: context)
        
        coreBook.name = book.name
        coreBook.author = book.author
        coreBook.artwork = book.artwork
        coreBook.bookLink = book.bookLink
        coreBook.bookLanguage = book.bookLanguage
        coreBook.bookCost = book.bookCost
        coreBook.publishedDate = book.publishedDate
        coreBook.publisher = book.publisher
        coreBook.bookDescription = book.description
        coreBook.uid = book.id

        saveContext()
        print("Book Saved: \(book.name) - \(book.author)")
    }
    
    func delete(_ book: Book)
    {
        let fetchRequest = NSFetchRequest<CoreBook>(entityName: "CoreBook")
        
        let namePredicate = NSPredicate(format: "name==%@", book.name)
        let idPredicate =  NSPredicate(format: "uid==%@", book.id)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [idPredicate, namePredicate])
        fetchRequest.predicate = compound
        
        do {
            let coreBooks = try context.fetch(fetchRequest) //query coredata for the data
            
            guard let core = coreBooks.first else {return} //coredata context fetch ALWAYS returns result set in array, grab the data in the first index
            context.delete(core) //remove that
            
            saveContext() //save the context, else the changes will not reflect throughout the core data
            print("Deleted Book: \(book.name)")

        }
        catch{
            print("Couldn't delete: \(error.localizedDescription)")
            
        }
        
    }
    
    //MARK: Helper
    func saveContext()
    {
        do {
            try context.save()
            
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    
}
