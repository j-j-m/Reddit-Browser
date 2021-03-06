//
//  RedditViewController.swift
//  Reddit
//
//  Created by Jacob Martin on 5/11/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit
import RedditComponents
import Moya

class RedditViewController : UIViewController {
    /// current sub. sets the title.
    var subreddit: String? {
        didSet {
            guard let sub = subreddit else {
                self.title = "Reddit"
                return
            }
            
            self.title = "r/" + sub
        }
    }
    
    lazy var tableview: UITableView = {
        let t = UITableView()
        t.autolayoutMode()
        t.rowHeight = UITableViewAutomaticDimension
        t.estimatedRowHeight = 200
        t.separatorStyle = .none
        t |> background(color: .white)
        return t
    }()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.dimsBackgroundDuringPresentation = false
        
       
        return search
    }()
    
    
    /// Data Source used to populate tableview with cells
    
    lazy var dataSource: DataSource<RedditService, Thing> = {
        let d = DataSource<RedditService, Thing>(){ p, d in
            
            // branch route based on existence of subreddit
            var sub = self.subreddit
            let route: RedditService = sub == nil ? .main(page: d.nextResourceIdentifier) : .subreddit(id: sub!, page: d.nextResourceIdentifier)
            
            
            p.request(route) { result in
                guard let value = result.value else { return }
                do {
                    // decode to object
                    let response = try RedditResponse.decode(from: value.data)
                    
                    // if response contains reference to next page of data... keep track of it on the data source.
                    if let after = response.data.after {
                        d.nextResourceIdentifier = after
                    }
                    
                    // append data to the data sources stored entities
                    d.append(response.data.children.map { $0.data })
                   
                    // reload
                    self.tableview.reloadData()
                } catch {
                    print(error)
                }
            }
        }
        
        tableview.dataSource = d
        tableview.delegate = self
        
        return d
        
    }()
    
    override func loadView() {
    
        let view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(tableview)
        
        self.view = view
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .search, target: self,
                                                              action: #selector(showSearchBar(sender:))),
                                              animated: true)

        
        title = "Reddit"
        tableview.register(PostCell.self, forCellReuseIdentifier: "ThingCell")
        prepareConstraints()
        
        dataSource.fill()
    }
}

// MARK: -  UITableViewDelegate

extension RedditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let entry = dataSource.entries[row]
        let vc = WebViewController()
        
        vc.urlString = "https://reddit.com" + dataSource.entries[row].permalink
        updateUIForSearchContext()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        guard let id = dataSource.nextResourceIdentifier,
            row >= dataSource.entries.count - 2 else { return }
        
        // if i get to this point then I have more data to retrieve. reload.
        tableView.beginUpdates()
        dataSource.fill()
        tableView.endUpdates()
    }
}


// MARK: -  UISearchResultsUpdating & UISearchBarDelegate

extension RedditViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    @objc func showSearchBar(sender: UIBarButtonItem) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    
    /// Close search field
    func updateUIForSearchContext() {
        defer { searchController.isActive = false }
    }
    
    
    /// update table and stored properties with search bar.
    ///
    /// - Parameter searchBar: the search bar.
    func refreshSearchContext(with searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            subreddit = nil
            searchUpdate()
            return
        }
        subreddit = searchText
        print(searchText)
        searchUpdate()
    }
    
    func searchUpdate() {
        dataSource.regenerate()
        tableview.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        refreshSearchContext(with: searchBar)
        updateUIForSearchContext()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
       // unimplimented
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshSearchContext(with: searchBar)
        
    }

}

