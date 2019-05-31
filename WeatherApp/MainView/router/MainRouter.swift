//
//  MainRouter.swift
//  WeatherApp
//
//  Created by wowow on 5/30/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: PresenterToRouterProtocol{
    static var mainstoryboard:UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    static func createModule() -> MainViewController {
        print("Router is creating modules")
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MainView") as! MainViewController
        
        var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = MainPresenter()
        var interactor: PresenterToInteractorProtocol & EntityToInteractorProtocol = MainInteractor()
        var router:PresenterToRouterProtocol = MainRouter()
        var entity:InteractorToEntityProtocol = DataModel()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.entity = entity
        entity.interactor = interactor
        
        return view
    }
    
    func pushToMainView(navigationController: UINavigationController) {
        let mainModule = MainRouter.createModule()
        navigationController.pushViewController(mainModule,animated: true)
        
        
    }
}
