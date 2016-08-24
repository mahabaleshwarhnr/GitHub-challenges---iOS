//
//  NSURLResponse+Extension.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 24/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import Foundation

extension NSURLResponse {
    
    var statusCode: Int {
        get {
            let httpResponse = self as! NSHTTPURLResponse
            return httpResponse.statusCode
        }
    }
    
    public func isSuccessCode() -> Bool {
        
        if 200 ... 299 ~= statusCode {
            print("success")
            return true
        } else {
            print("Failure")
            return false
        }
    }
}