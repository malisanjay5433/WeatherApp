//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Sanjay Mali on 25/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell{
    @IBOutlet weak var date:UILabel!
    @IBOutlet weak var low:UILabel!
    @IBOutlet weak var high:UILabel!
    @IBOutlet weak var sign:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
