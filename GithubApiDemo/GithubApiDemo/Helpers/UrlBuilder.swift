//
//  UrlBuilder.swift
//  GithubApiDemo
//
//  Created by DP Samant on 23/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import Foundation

public class UrlBuilder {
   
    private static func getHostUrl() -> String {
        return "https://api.github.com"
    }
    
    static func getRepositoriesUrl() -> String {
        return getHostUrl() + "/search/repositories"
    }
}