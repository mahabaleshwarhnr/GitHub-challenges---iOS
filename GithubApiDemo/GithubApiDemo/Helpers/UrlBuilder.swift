//
//  UrlBuilder.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import Foundation

public class UrlBuilder {
   
    static var per_page = 20
    static var pageNumber = 1
    
    private static func getHostUrl() -> String {
        return "https://api.github.com"
    }
    
    static func getPageInfo() {
        
    }
    
    static func getRepositoriesUrl(forLanguage: String) -> String {
        //https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc&page=1&per_page=10
        return getHostUrl() + "/search/repositories?q=language:" + forLanguage + "&sort=stars&order=desc&page=\(pageNumber)&per_page=\(per_page)"
    }
}