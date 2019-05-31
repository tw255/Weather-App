//
//  MainViewController.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import CoreLocation

var detailedListF:(String,String,String,String)?

class MainViewController: UIViewController,CLLocationManagerDelegate{
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var presenter: ViewToPresenterProtocol?
    var detailedPresenter: DetailedViewToPresenterProtocol?
    
    var weatherList:[(String,Double,UIImage)] = []
    var detailedList:[(String,String,String)] = []

    let locationManager = CLLocationManager()
    var usersLocation:CLLocation?
    var usersFinalLoc:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pullBaseData()
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        let cellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.register(cellNib, forCellReuseIdentifier: "weatherCell")
    }

    @IBAction func refreshPressed(_ sender: Any) {
        pullBaseData()
    }
    
    func pullBaseData(){
        weatherList = []
        detailedList = []
        
        locationManager.requestWhenInUseAuthorization()
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            usersLocation = locationManager.location
            guard let lat = usersLocation?.coordinate.latitude else{return}
            guard let lon = usersLocation?.coordinate.longitude else{return}
            usersFinalLoc = "lat=\(lat)&lon=\(lon)"
            presenter?.startFetchingData(usersLocation:usersFinalLoc!)
            
        }else{
            presenter?.startFetchingData(usersLocation:"jersey+city,US")
        }
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! HomeTableViewCell
        
        cell.cellLocation.text = weatherList[indexPath.row].0
        cell.cellTemp.text = "\(Int(round(weatherList[indexPath.row].1))) °F"
        cell.cellImage.image = weatherList[indexPath.row].2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else{return}
        detailedListF = (detailedList[indexPath.row].0,detailedList[indexPath.row].1,detailedList[indexPath.row].2,weatherList[indexPath.row].0)
        let detailedModule = DetailedRouter.createModule()
        navigationController.pushViewController(detailedModule,animated: true)
    }
}



extension MainViewController: PresenterToViewProtocol{
    func showData(weatherArray: [(String, Double, UIImage)]) {
        weatherList = weatherArray
        DispatchQueue.main.async{
        self.homeTableView.reloadData()
        }
    }
    func showDetailedData(detailedArray:[(String,String,String)]){
        detailedList = detailedArray
    }
    func showError() {
        let alert = UIAlertController(title: "Loading failed with some error", message: "Try pressing the refresh button at the top right to try again", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}


