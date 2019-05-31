//
//  MainInteractor.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class MainInteractor: PresenterToInteractorProtocol{
    
    var presenter: InteractorToPresenterProtocol?
    var entity: InteractorToEntityProtocol?
    
    var weatherArr:[(String, Double, UIImage)] = []
    
    enum NetworkError:Error {
        case url
    }
    
    func fetchWeatherData(withURL:String) throws {
        let jsonURL = "https://api.openweathermap.org/data/2.5/weather?\(withURL)&units=imperial&appid=49cb4af2d912975fb6942414a1614bc4"
        guard let URL = URL(string: jsonURL) else{throw NetworkError.url}
        
        URLSession.shared.dataTask(with: URL) {(data, response, error) in
            guard let data = data else{
                guard let error = error else{return}
                self.dataFetchFailed(error: error)
                return
            }
            
            self.entity?.parseData(data: data) {(location,temp,image,windSpeed,windDeg,clouds) in
                self.presenter?.dataFetchedSuccess(weatherData: (location,temp,image))
                
                
                self.presenter?.dataForDetailedViewSuccess(detailedData: (windSpeed,windDeg,clouds))
            }
            }.resume()
    }
    
}
extension MainInteractor: EntityToInteractorProtocol{
    func fetchIconData(icon:String, completion:@escaping(UIImage) -> ()) {
        guard let url = URL(string: "https://openweathermap.org/img/w/\(icon).png") else{return}
        let data = try? Data(contentsOf: url)
        
        guard let imageData = data else{return}
        guard let image = UIImage(data: imageData) else{return}
        completion(image)
    }
    
    func dataFetchSuccess(weatherArr:[(String,Double,UIImage)]) {
        //        presenter?.dataFetchedSuccess(weatherData:)
    }
    
    func dataFetchFailed(error:Error) {
        print(error)
        presenter?.dataFetchFailed()
    }
    
    
}

