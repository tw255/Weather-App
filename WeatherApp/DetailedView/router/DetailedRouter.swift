//
//  DetailedRouter.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class DetailedRouter: DetailedPresenterToRouterProtocol{
    static var mainstoryboard:UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static func createModule() -> DetailedViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DetailedView") as! DetailedViewController
        
        
        return view
    }
    
    func pushToDetailedView(navigationController: UINavigationController) {
        let detailedModule = DetailedRouter.createModule()
        
        navigationController.pushViewController(detailedModule, animated: true)
    }
}

