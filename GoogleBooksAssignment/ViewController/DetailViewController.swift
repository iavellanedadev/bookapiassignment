//
//  DetailViewController.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailMainLabel: UILabel!
    
    @IBOutlet weak var detailMainImage: UIImageView!
    
    @IBOutlet weak var detailAuthorLabel: UILabel!
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
        
    @IBOutlet weak var detailLanguageLabel: UILabel!
    
    @IBOutlet weak var detailPriceLabel: UILabel!
    
    @IBOutlet weak var detailPublishDateLabel: UILabel!
    
    @IBOutlet weak var detailPublisherLabel: UILabel!
    
    @IBOutlet weak var urlButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var hideButton: Bool = false
    
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetails()
        
        if hideButton
        {
            favoriteButton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func urlTouch(_ sender: UIButton) {
        
        print(viewModel.currentBook.bookLink)
        
        if let url = NSURL(string: viewModel.currentBook.bookLink){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func favoriteTouch(_ sender: UIButton) {
        CoreManager.shared.save(viewModel.currentBook)

        let alertController = UIAlertController(title:"\(viewModel.currentBook.name) - \(viewModel.currentBook.author)", message:
              "\(viewModel.currentBook.name) has been added to your favorites", preferredStyle: .alert)
          alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

          present(alertController, animated: true, completion: nil)
        
        favoriteButton.isHidden = true

    }
    
    private func setupDetails()
    {
        detailMainLabel.text = viewModel.currentBook.name
        detailAuthorLabel.text = "By: " + viewModel.currentBook.author
        detailDescriptionLabel.text = viewModel.currentBook.description
        detailLanguageLabel.text = "Language: " + viewModel.currentBook.bookLanguage
        detailPriceLabel.text = "Price: \(viewModel.currentBook.bookCost)"
        detailPublisherLabel.text = "Publisher: " + viewModel.currentBook.publisher
        detailPublishDateLabel.text = "Date Published: " + viewModel.currentBook.publishedDate
        
        
        
        //TODO: Download Image To Be Displayed
        guard let artworkUrl = URL(string: viewModel.currentBook.artwork) else { return }
        artworkUrl.getImage{
            [weak self] img in
            if let image = img{
                self?.detailMainImage.image = image
            }
        }
    }

}
