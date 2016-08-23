//
//  HttpTasksHandler.swift
//  GithubApiDemo
//
//  Created by DP Samant on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import Foundation

class HttpTasksHandler {
    
    typealias CompletionHandler = (reponseData: NSData, error: NSError) -> Void
    
    var completionHandler: CompletionHandler?
    
    
    init() {
        
    }
    
    func downloadRepositoriesList(langauage: String, completionHandler: CompletionHandler? = nil) -> Void {
        
    }
    
}
