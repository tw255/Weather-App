//
//  HomeTableViewCell.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellLocation: UILabel!
    @IBOutlet var cellTemp: UILabel!
    @IBOutlet var cellContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellContainer.layer.cornerRadius = 8 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
