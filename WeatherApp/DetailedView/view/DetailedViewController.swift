//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet var mainView: UIImageView!
    @IBOutlet var mainContainer: UIView!
    
//    var windSpeed:String!
//    var windDeg:String!
//    var clouds:String!
    @IBOutlet var locationPicked: UILabel!
    @IBOutlet var windS: UILabel!
    @IBOutlet var windD: UILabel!
    @IBOutlet var cloudS: UILabel!
    @IBOutlet var staticWind: UILabel!
    @IBOutlet var staticClouds: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainContainer.layer.cornerRadius = 8
        
        guard let windSpeed = detailedListF?.0 else{return}
        guard let windDeg = detailedListF?.1 else{return}
        guard let clouds = detailedListF?.2 else{return}
        guard let location = detailedListF?.3 else{return}
        
        locationPicked.text = location
        windS.text = "Wind Speed: \(windSpeed)"
        windD.text = "Wind Degree: \(windDeg)"
        cloudS.text = "Overcast: \(clouds)"
        
        locationPicked.sizeToFit()
        staticWind.sizeToFit()
        staticClouds.sizeToFit()

    }
    

}
