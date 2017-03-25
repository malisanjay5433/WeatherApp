//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sanjay Mali on 24/03/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var titleLabel:UILabel!
    
    var model = [WeatherModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "maxresdefault")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 60
        loadJSON()
    }
    func loadJSON(){
        let api = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22chicago%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        Alamofire.request(api).responseJSON { response in
            //print(response.result)   // result of response serialization
            guard response.result.error == nil else {
                print(response.result.error!)
                return
            }
            if let json = response.data {
                let json_Data = JSON(data:json)
                let query = json_Data["query"].dictionary!
                let results = query["results"]?.dictionary!
                let channel = results?["channel"]?.dictionary!
                let title = channel?["title"]?.string
                self.titleLabel.text = title
                let item = channel?["item"]?.dictionary!
                let forecast = item?["forecast"]?.array!
                print("forecast:\(forecast)")
                for i in forecast!{
                    let items = WeatherModel(json:i)
                    self.model.append(items)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.model.count)
            }
            
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! WeatherCell
        cell.backgroundColor = UIColor.clear
        if  model[indexPath.row].text == "Rain"{
            cell.date?.text = model[indexPath.row].date!
            cell.low?.text = model[indexPath.row].low! + " L"
            cell.high?.text = model[indexPath.row].high! + " H"
            cell.sign.image = UIImage(named:"rainy")
        }else if model[indexPath.row].text == "Scattered Thunderstorms" || model[indexPath.row].text == "Scattered"{
            cell.date?.text = model[indexPath.row].date!
            cell.low?.text = model[indexPath.row].low! + " L"
            cell.high?.text = model[indexPath.row].high! + " H"
            cell.sign.image = UIImage(named:"scattered")
        }else if model[indexPath.row].text == "Cloudy" || model[indexPath.row].text == "Mostly Cloudy" {
            cell.date?.text = model[indexPath.row].date!
            cell.low?.text = model[indexPath.row].low! + " L"
            cell.high?.text = model[indexPath.row].high! + " H"
            cell.sign.image = UIImage(named:"cloudy")
        }
        return cell
    }
    
}

