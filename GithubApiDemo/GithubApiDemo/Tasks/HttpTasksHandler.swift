//
//  HttpTasksHandler.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import Foundation
import UIKit

class HttpTasksHandler {
    
    typealias CompletionHandler = (reponseData: NSData?, response: NSURLResponse?, error: NSError?) -> Void
    
    var completionHandler: CompletionHandler?
    var taskType: HttpTaskType
    var dataTask: NSURLSessionDataTask?
    
    private var hostUrl: String
    let defaultSession: NSURLSession
    
    
    //MARK:- Initialization
    
    init(taskType: HttpTaskType, info:[String: AnyObject]) {
        
        self.taskType = taskType
        defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        switch self.taskType {
        
        case .DownloadRepositories:
              let language = info["langauage"] as! String
              self.hostUrl = UrlBuilder.getRepositoriesUrl(language)
              downloadRepositoriesList(language)
              break
        }
        
    }
    
    ////MARK:- Helper Methods
    
    func downloadRepositoriesList(langauage: String, completionHandler: CompletionHandler? = nil) -> Void {
        
        let serviceUrl = NSURL(string: self.hostUrl)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.dataTask = self.defaultSession.dataTaskWithURL(serviceUrl!, completionHandler: { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                completionHandler!(reponseData: data!, response: response!, error: error!)
            }
        })
        
        dataTask?.resume()
        
    }
    
}
