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
