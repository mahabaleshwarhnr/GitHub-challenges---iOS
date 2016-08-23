//
//  ViewController.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchController: UISearchController!
    var searchTableViewController: SearchTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSearchController() {
        
        self.searchTableViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchTableViewController") as! SearchTableViewController
        searchController  = UISearchController(searchResultsController: self.searchTableViewController)
        self.searchController.searchResultsUpdater = searchTableViewController
        self.searchController.delegate = self
        self.searchTableViewController.deleagte = self
        self.searchController.searchBar.placeholder = "Select the programming langauage"
        self.searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.titleView = self.searchController.searchBar
        
    }
    
}

//MARK:- UISearchControllerDelegate

extension ViewController: UISearchControllerDelegate {
    
    func willPresentSearchController(searchController: UISearchController) {
        
        dispatch_async(dispatch_get_main_queue()) {
            searchController.searchResultsController?.view.hidden = false
        }
    }
}

//MARK:- UISearchControllerDelegate

extension ViewController: SearchTableViewControllerDelegate {
    
    func didSelectLanguage(langauage: String) {
        
        print("Selected Language is \(langauage)")
    }
}




