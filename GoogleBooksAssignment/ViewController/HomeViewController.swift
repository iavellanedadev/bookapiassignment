//
//  HomeViewController.swift
//  GoogleBooksAssignment
//
//  Created by Consultant on 12/21/19.
//  Copyright © 2019 Consultant. All rights reserved.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    let viewModel = ViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupHome()
         searchSetup()
    }

    private func setupHome()
    {
        homeTableView.register(UINib(nibName: BookTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: BookTableViewCell.identifier)
        
        homeTableView.tableFooterView = UIView(frame: .zero)
        
        homeTableView.separatorStyle = .none
        
        homeTableView.backgroundColor = UIColor.tableGray
        viewModel.delegate = self
        viewModel.get("book")
    }
    
    private func searchSetup()
    {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension HomeViewController: UITableViewDataSource
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
      
    
        let book = viewModel.books[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = viewModel.books[indexPath.row]
        viewModel.currentBook = book
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.viewModel = viewModel 
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: ViewModelDelegate{
    func update()
    {
        DispatchQueue.main.async{
            self.homeTableView.reloadData()
        }
    }
}

extension HomeViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text,
        let sanitized = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        viewModel.get(sanitized)
    }
}
