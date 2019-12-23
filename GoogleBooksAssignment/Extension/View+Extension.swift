//
//  View+Extension.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

extension UIView
{

    
    func addShadow() {

    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    self.layer.shadowRadius = 2.0
    self.layer.shadowOpacity = 1.0
    self.layer.masksToBounds = false

    }
}
