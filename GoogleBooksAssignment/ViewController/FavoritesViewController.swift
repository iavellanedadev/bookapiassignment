//
//  FavoritesViewController.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoriteTableView: UITableView!

    
    
    var books = [Book]()
    {
        didSet{
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavorite()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        books = CoreManager.shared.load()
        
    }
    
    private func setupFavorite()
    {
        
        favoriteTableView.register(UINib(nibName: BookTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BookTableViewCell.identifier)
        
        favoriteTableView.tableFooterView = UIView(frame: .zero)
        favoriteTableView.backgroundColor = UIColor.tableGray
        favoriteTableView.separatorStyle = .none
    }

}

extension FavoritesViewController: UITableViewDataSource
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
      
    
        let book = books[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = books[indexPath.row]
        viewModel.currentBook = book
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.viewModel = viewModel
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.hideButton = true
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
