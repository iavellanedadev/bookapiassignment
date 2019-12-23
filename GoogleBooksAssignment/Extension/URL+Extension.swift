//
//  URL+Extension.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit

extension URL{
    func getImage(completion: @escaping (UIImage?) -> Void)
    {
        URLSession.shared.dataTask(with: self) { (dat, _, _) in
            if let data = dat{
                DispatchQueue.main.async{
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
            
        }.resume()
    }
}
