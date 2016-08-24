//
//  Repositories.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 24/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import Foundation

class Repositories: NSObject {

    var id: Double = -1
    var name: String!
    var langauage: String!
    var contributorsUrl: String!
    var repoDescription: String!
    var openIssuesCount: Double = -1 // By default set to -1
    var issuesUrl: String!
    var issuesCommentUrl: String!
    var avatarUrl: String!
    
}
