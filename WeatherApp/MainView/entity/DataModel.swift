//
//  DataModel.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

struct Coord:Decodable{
    let lat:Double?
    let lon:Double?
}
struct Weather:Decodable{
    let id:Int?
    let main:String?
    let description:String?
    let icon:String?
}
struct Main:Decodable{
    let temp:Double?
    let pressure:Int?
    let humidity:Int?
    let temp_min:Double?
    let temp_max:Double?
}
struct Wind:Decodable{
    let speed:Double?
    let deg:Double?
}
struct Rain:Decodable{
    let oneH:Double?
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}
struct Clouds:Decodable{
    let all:Double?
}
struct Sys:Decodable{
    let type:Int?
    let id:Int?
    let message:Double?
    let country:String?
    let sunrise:Int?
    let sunset:Int?
}
struct Final:Decodable{
    let coord:Coord
    let weather:[Weather]
    let base:String?
    let main:Main
    let visibility:Int?
    let wind:Wind?
    let rain:Rain?
    let clouds:Clouds
    let dt:Int?
    let sys:Sys
    let timezone:Int?
    let id:Int?
    let name:String?
    let cod:Int?
}

class DataModel: InteractorToEntityProtocol{
    var interactor: EntityToInteractorProtocol?
    //var weatherArr:[(String, Double, UIImage)] = []
    
    func parseData(data: Any,completion:@escaping(String,Double,UIImage,Double,Double,Double) -> ()){
        do {
            let weatherData = try JSONDecoder().decode(Final.self, from: data as! Data)
            
            guard let icon = weatherData.weather.first?.icon else{return}
            guard let temp = weatherData.main.temp else{return}
            guard let city = weatherData.name else{return}
            guard let country = weatherData.sys.country else{return}
            guard let windSpeed = weatherData.wind?.speed else{return}
            guard let windDeg = weatherData.wind?.deg else{return}
            guard let clouds = weatherData.clouds.all else{return}
            
            let location = "\(city), \(country)"
            //            guard let location = "\(weatherData.name), \(weatherData.sys.country)" else{return}
            interactor?.fetchIconData(icon:icon){image in
                completion(location,temp,image,windSpeed,windDeg,clouds)
            }
        } catch let jsonErr{
            print(jsonErr)
            interactor?.dataFetchFailed(error: jsonErr)
        }
    }
}


