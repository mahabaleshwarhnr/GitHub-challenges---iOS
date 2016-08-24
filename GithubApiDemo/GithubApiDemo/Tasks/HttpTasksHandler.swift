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
    var taskType: HttpTaskType = .None
    var dataTask: NSURLSessionDataTask?
    
    private var hostUrl: String?
    let defaultSession: NSURLSession
    
    
    //MARK:- Initialization
    
    init?() {
        
        defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
    
    func sendGetRequest(taskType: HttpTaskType,info:[String: AnyObject]?, completionHandler:CompletionHandler) -> Void {
        
        self.completionHandler = completionHandler
        
        switch taskType {
        case .DownloadRepositories:
            let language = (info!["langauage"] as! String).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            self.hostUrl = UrlBuilder.getRepositoriesUrl(language!)
            downloadRepositoriesList(language!, completionHandler: completionHandler)
            break
        default:
            break
        }
    }
    
    ////MARK:- Helper Methods
    
    func downloadRepositoriesList(langauage: String, completionHandler: CompletionHandler) -> Void {
        
        let serviceUrl = NSURL(string: self.hostUrl!)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.dataTask = self.defaultSession.dataTaskWithURL(serviceUrl!, completionHandler: { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                //completionHandler(reponseData: data!, response: response!, error: error!)
                
                self.completionHandler!(reponseData: data, response: response, error: error)
            }
        })
        
        dataTask?.resume()
    }
    
    
}
