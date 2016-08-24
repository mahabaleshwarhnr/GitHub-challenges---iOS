//
//  BaseViewController.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 24/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var alertController: UIAlertController?
    var appName: String {
        get {
            return "GitMan"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func showSimpleAlert(message: String) -> Void {
        
        alertController = UIAlertController(title: appName, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController?.addAction(okAction)
        self.presentViewController(alertController!, animated: true, completion: nil)
        
    }
}
