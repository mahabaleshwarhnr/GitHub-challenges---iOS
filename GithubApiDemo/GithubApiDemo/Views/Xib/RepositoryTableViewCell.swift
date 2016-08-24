//
//  RepositoryTableViewCell.swift
//  GithubApiDemo
//
//  Created by Mahabaleshwar on 24/08/16.
//  Copyright © 2016 DP Samant. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
