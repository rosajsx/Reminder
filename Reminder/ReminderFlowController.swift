//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by Lucas Rosa  on 27/12/24.
//

import Foundation
import UIKit

class ReminderFlowController {
    //MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactory
    //MARK: - init
    public init(){
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    //MARK: - startFlow
    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

//MARK: - Splash
extension ReminderFlowController: SplashViewFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheetController = viewControllerFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheetController.modalPresentationStyle = .overCurrentContext
        loginBottomSheetController.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.present(loginBottomSheetController, animated: false, completion: {
            loginBottomSheetController.animateShow()
        })
    }
}


//MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: false)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
