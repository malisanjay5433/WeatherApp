//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Sanjay Mali on 25/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import SwiftyJSON
class WeatherModel: NSObject {
    var date:String?
    var low:String?
    var high:String?
    var text:String?
    required init(json:JSON) {
        self.date = json["date"].string
        self.low = json["low"].string
        self.high = json["high"].string
        self.text = json["text"].string
    }
}
