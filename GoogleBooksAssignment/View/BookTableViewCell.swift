//
//  BookTableViewCell.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookBackView: UIView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookMainLabel: UILabel!
    @IBOutlet weak var bookSubLabel: UILabel!
    
    static let identifier = "BookTableViewCell"
    
    var book: Book! {
        didSet{
            bookMainLabel.text = book.name
            bookSubLabel.text = book.author

            guard let artworkUrl = URL(string: book.artwork) else { return }
            artworkUrl.getImage{
                [weak self] img in
                if let image = img{
                    self?.bookImage.image = image
                }
            }
        }
    }
    //TODO: Configuration Inside the Table Cell
    override func layoutSubviews() {
        self.bookBackView.layer.cornerRadius = 15
              self.bookBackView.addShadow()
              self.backgroundColor = .clear
    }
    
}
