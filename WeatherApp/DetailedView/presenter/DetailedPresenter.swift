//
//  DetailedPresenter.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class DetailedPresenter: DetailedViewToPresenterProtocol{
    var detailedRouter: DetailedPresenterToRouterProtocol?
    
    func showDetailedViewController(navigationController: UINavigationController) {
        detailedRouter?.pushToDetailedView(navigationController: navigationController)
    }
    
    
}
