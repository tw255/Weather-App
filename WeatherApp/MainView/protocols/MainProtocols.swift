//
//  MainProtocols.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol {
    var view:PresenterToViewProtocol? {get set}
    var interactor:PresenterToInteractorProtocol? {get set}
    var router:PresenterToRouterProtocol? {get set}
//    var detailedRouter: DetailedViewToPresenterProtocol? {get set}
    func startFetchingData(usersLocation:String)
    func showMainViewController(navigationController:UINavigationController)
}



protocol PresenterToRouterProtocol{
    static func createModule()-> MainViewController
    func pushToMainView(navigationController:UINavigationController)
}
protocol PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol? {get set}
    var entity:InteractorToEntityProtocol? {get set}
    func fetchWeatherData(withURL:String) throws
}
protocol PresenterToViewProtocol{
    func showData(weatherArray:[(String,Double,UIImage)])
    func showDetailedData(detailedArray:[(String,String,String)])
    func showError()
}



protocol InteractorToEntityProtocol{
    var interactor: EntityToInteractorProtocol? {get set}
    func parseData(data:Any, completion:@escaping(String,Double,UIImage,Double,Double,Double) -> ())
}
protocol InteractorToPresenterProtocol{
    func dataFetchedSuccess(weatherData:(String, Double, UIImage))
    func dataForDetailedViewSuccess(detailedData: (Double,Double,Double))
    func dataFetchFailed()
}



protocol EntityToInteractorProtocol{
    func fetchIconData(icon:String, completion:@escaping(UIImage) -> ())
    func dataFetchSuccess(weatherArr:[(String,Double,UIImage)])
    func dataFetchFailed(error:Error)
}


