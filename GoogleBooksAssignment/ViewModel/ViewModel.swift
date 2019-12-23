//
//  ViewModel.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class
{
    func update()
}


class ViewModel
{
    weak var delegate: ViewModelDelegate?
    var books = [Book]()
    {
        didSet{
            delegate?.update()
        }
    }
    

    
    var currentBook: Book!
    {
        didSet{
            get(currentBook.id)
        }
    }
    
   
}

extension ViewModel{
    func get(_ name: String)
       {
        
        google.getBooks(for: name) { [weak self] bookResult in
               switch bookResult
               {
               case .success(let books):
                   self?.books = books
                   print("Book Count: \(books.count)")
                   break
               case .failure (let error):
                   print("Failed: \(error.localizedDescription)")
                   break
                   
               }
           }
       }
    

}
