//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class MainPresenter: ViewToPresenterProtocol{
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    
    var weatherArr:[(String, Double, UIImage)] = []
    var detailedArr:[(String,String,String)] = []
    
    func startFetchingData(usersLocation:String) {
        do{
            try interactor?.fetchWeatherData(withURL:usersLocation)
        } catch{
            print("URL does not lead to anything")
        }
        
        do{
            try interactor?.fetchWeatherData(withURL:"q=london,UK")
            
        } catch{
            print("URL does not lead to anything")
        }
        
        do{
            try interactor?.fetchWeatherData(withURL:"q=tokyo,JP")
            
        } catch{
            print("URL does not lead to anything")
        }
        
    }
    
    func showMainViewController(navigationController: UINavigationController) {
                router?.pushToMainView(navigationController:navigationController)
    }
    
}

extension MainPresenter: InteractorToPresenterProtocol{
    
    func dataFetchedSuccess(weatherData: (String, Double, UIImage)) {
        weatherArr.append(weatherData)
        if weatherArr.count == 3{
            view?.showData(weatherArray: weatherArr)
            weatherArr = []
        }
        
    }
    func dataForDetailedViewSuccess(detailedData:(Double,Double,Double)){
        let dir = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((detailedData.1/45).rounded()) % 8
        let windSpeed = "\(detailedData.0) MPH"
        let clouds = "\(Int(detailedData.2))%"
        
        detailedArr.append((windSpeed,dir[index],clouds))
        if detailedArr.count == 3{
            view?.showDetailedData(detailedArray:detailedArr)
            detailedArr = []
        }
    }
    
    func dataFetchFailed() {
        view?.showError()
    }
}
