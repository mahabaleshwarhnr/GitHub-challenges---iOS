//
//  ViewController.swift
//  GithubApiDemo
//
//  Created by Mahabaleswar Hegde on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    var searchController: UISearchController!
    var searchTableViewController: SearchTableViewController!
    var repositories = [Repositories]()
    var httpTaskHandler: HttpTasksHandler? = nil
    private var selectedLanguage: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cellNib = UINib(nibName: "RepositoryTableViewCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "RepositoryNameCell")
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        setupSearchController()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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

//MARK:- UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryNameCell", forIndexPath: indexPath) as! RepositoryTableViewCell
        let repository = self.repositories[indexPath.row]
        cell.nameLabel?.text = repository.name
        cell.descriptionLabel?.text = repository.repoDescription
        
        cell.updateConstraintsIfNeeded()
        return cell
        
    }
}

//MARK:- UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == repositories.count - 2 {
            getRepositoriesList(self.selectedLanguage!)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

//MARK:- SearchTableViewControllerDelegate

extension ViewController: SearchTableViewControllerDelegate {
    
    func didSelectLanguage(langauage: String) {
        
        print("Selected Language is \(langauage)")
        if self.repositories.count > 0 {
            self.repositories.removeAll()
            self.tableView.reloadData()
        }
        self.selectedLanguage = langauage
        getRepositoriesList(langauage)
        
    }
}

//MARK:- Web Services Methods

extension ViewController {
    
    func getRepositoriesList(langauage: String) -> Void {
        
        let userInfo = ["langauage":langauage]
        if self.httpTaskHandler == nil {
            self.httpTaskHandler = HttpTasksHandler()
        }
        self.httpTaskHandler?.sendGetRequest(.DownloadRepositories,
                                             info: userInfo,
                                             completionHandler: { (reponseData, response, error) in
                                                if response?.isSuccessCode() == true {
                                                    do {
                                                        let json = try NSJSONSerialization.JSONObjectWithData(reponseData!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                                                        print("getRepositoriesList response is \(json)")
                                                        self.updateSearchResult(json!)
                                                        
                                                    } catch {
                                                        print(error)
                                                    }
                                                } else {
                                                    print("Status code is:\(response?.statusCode)")
                                                    if response?.statusCode == 0 {
                                                        self.showSimpleAlert("Check your network Connection")
                                                    }
                                                }
                                                
        })
    }
}

//MARK: Helper Methods

extension ViewController {
    
    func updateSearchResult(result: [String: AnyObject]) -> Void {
        
        if let items = result[Constants.Items] as? [[String: AnyObject]] {
            for repoItem in items {
                let repository = Repositories()
                repository.name = repoItem["name"] as? String
                repository.repoDescription = repoItem["description"] as? String
                repository.id = (repoItem["id"] as? Double)!
                repository.openIssuesCount = (repoItem["open_issues"] as? Double)!
                repository.issuesUrl = repoItem["issues_url"] as? String
                repository.issuesCommentUrl = repoItem["issue_comment_url"] as? String
                repository.contributorsUrl = repoItem["contributors_url"] as? String
                self.repositories.append(repository)
            }
            self.tableView.reloadData()
        }
    }
}



