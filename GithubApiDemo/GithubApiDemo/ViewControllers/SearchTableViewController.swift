//
//  SearchTableViewController.swift
//  GithubApiDemo
//
//  Created by DP Samant on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import UIKit

protocol SearchTableViewControllerDelegate: NSObjectProtocol {
    
    func didSelectLanguage(langauage: String)
}

class SearchTableViewController: UITableViewController {
    
    //properties
    var languageList = []
    var languageFilterList = []
    weak var deleagte: SearchTableViewControllerDelegate?
    weak var searchController: UISearchController!
    private var isSearchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("github", ofType: "plist")
        languageList = NSArray(contentsOfFile: path!)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            return languageFilterList.count
        } else {
            return languageList.count
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("LanguageCell", forIndexPath: indexPath)
        if !isSearchActive {
            cell.textLabel?.text = languageList[indexPath.row] as? String
        } else {
           cell.textLabel?.text = languageFilterList[indexPath.row] as? String
        }
        
        return cell
    }
}

//MARK:- UITableViewDelegate

extension SearchTableViewController  {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var lanagauage = ""
        if isSearchActive {
            lanagauage =  languageFilterList[indexPath.row] as! String
        } else {
            lanagauage =  languageList[indexPath.row] as! String
        }
        deleagte?.didSelectLanguage(lanagauage)
        self.searchController.active = false
    }
}

//MARK:- UISearchResultsUpdating

extension SearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        self.searchController = searchController
        if searchController.searchBar.text?.isEmpty == true {
            self.view.hidden = false
            isSearchActive = false
        } else {
            isSearchActive = true
            languageFilterList = self.languageList.filter { $0.lowercaseString.containsString((searchController.searchBar.text?.lowercaseString)!)}
        }
        self.tableView.reloadData()
    }
}


