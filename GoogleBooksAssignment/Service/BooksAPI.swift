//
//  BooksAPI.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

struct BooksAPI
{
    var bookName: String! //implicit unwrap
    
    let base = "https://www.googleapis.com/books/v1"
    let search = "/volumes?"

    //let term = ""
    
    init(_ name: String? = nil)
    {
        self.bookName = name
 
    }
    
    var bookUrl: URL? {
        guard let name = bookName else {return nil}
        return URL(string: base + search + "q=\(name)")
    }
    

    

}

