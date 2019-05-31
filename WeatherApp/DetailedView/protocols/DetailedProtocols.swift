//
//  DetailedProtocols.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

protocol DetailedViewToPresenterProtocol {
    var detailedRouter:DetailedPresenterToRouterProtocol? {get set}
    func showDetailedViewController(navigationController:UINavigationController)
}

protocol DetailedPresenterToRouterProtocol{
    static func createModule()-> DetailedViewController
    func pushToDetailedView(navigationController:UINavigationController)
}

