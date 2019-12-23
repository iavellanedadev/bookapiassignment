//
//  Book.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

struct Book
{
    let id: String
    let name: String
    let author: String
    let publishedDate: String
    let artwork: String
    let bookCost: Double
    let bookLanguage: String
    let description: String
    let publisher: String
    let bookLink: String

    

}

extension Book{
    init (_ core: CoreBook)
    {
        self.id = core.uid!
        self.name = core.name!
        self.author = core.author!
        self.artwork = core.artwork!
        self.bookLink = core.bookLink!
        self.description = core.bookDescription!
        self.publishedDate = core.publishedDate!
        self.bookCost = core.bookCost
        self.bookLanguage = core.bookLanguage!
        self.publisher = core.publisher!
    }
}
