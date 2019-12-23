//
//  BooksService.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

enum BooksError: Error{
    case badUrl(String)
    case badDataTask(String)
    case badDecoder(String)
}

typealias BooksHandler = (Result<[Book], BooksError>) -> Void


let google = BooksService.shared

final class BooksService
{
    static let shared = BooksService()
    
    private init(){}
    
    //MARK: Get Album
    func getBooks(for book: String, completion: @escaping BooksHandler)
    {
        guard let url = BooksAPI(book).bookUrl else {
            completion(.failure(.badUrl("Couldn't Create Book URL")))
            return }
        
        var libros = [Book]()

        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            //safety valve here, we won't use any variable for the error, unless you want to print it, so we simply use _ to say 'placeholder variable'
            
            DispatchQueue.main.async {
                if let error = err{
                    completion(.failure(.badDataTask(error.localizedDescription)))
                    return
                }
            
                if let data = dat{
                    do{
                        let jsonResp = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>
                        guard let items = jsonResp["items"] else {
                            return }
                        
                            for element in items as! Array<AnyObject>
                            {
                                
                                if let id = element["id"] as? String,
                                    let volumeDict = element["volumeInfo"] as? [String:Any],
                                let title = volumeDict["title"] as? String,
                                let authorDict = volumeDict["authors"] as? [String],
                                let publishedDate = volumeDict["publishedDate"] as? String,
                                    let imageDict = volumeDict["imageLinks"] as? [String:Any],
                                let artwork = imageDict["thumbnail"] as? String,
                                let description = volumeDict["description"] as? String,
                                    let saleDict = element["saleInfo"] as? [String:Any],
                                let bookLanguage = volumeDict["language"] as? String,
                                let bookLink = volumeDict["infoLink"] as? String
                                {
                                    var bookCost = 0.00
                                      var publisher = "N/A"
                                      if let retailDict = saleDict["retailPrice"] as? [String:Any],
                                          let amt = retailDict["amount"] as? Double,
                                          let publish = volumeDict["publisher"] as? String
                                      {
                                          bookCost = amt
                                          publisher = publish
                                      }
                                    
                                      let libro = Book(id: id, name: title, author: authorDict[0], publishedDate: publishedDate, artwork: artwork, bookCost: bookCost, bookLanguage: bookLanguage, description: description, publisher: publisher, bookLink: bookLink )
                                                           
                                       libros.append(libro)
                                }
                                
  
                           
                            }
                        
                        completion(.success(libros))
                    }catch{
                        completion(.failure(.badDataTask(error.localizedDescription)))

                        return
                    }

                }
            }
            
            
        }.resume()
    }
    
    
}
