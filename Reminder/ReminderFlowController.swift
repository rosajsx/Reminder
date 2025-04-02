//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by Lucas Rosa  on 27/12/24.
//

import Foundation
import UIKit

class ReminderFlowController {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactory
    // MARK: - init
    public init() {
        self.viewControllerFactory = ViewControllersFactory()
    }

    // MARK: - startFlow
    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

// MARK: - Splash
extension ReminderFlowController: SplashViewFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheetController = viewControllerFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheetController.modalPresentationStyle = .overCurrentContext
        loginBottomSheetController.modalTransitionStyle = .crossDissolve

        self.navigationController?.present(loginBottomSheetController, animated: false, completion: {
            loginBottomSheetController.animateShow()
        })
    }

    func navigateHome() {
        self.navigationController?.dismiss(animated: false)
        let homeViewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)

        self.navigationController?.pushViewController(homeViewController, animated: true)
    }

}

// MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: false)
        let homeViewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)

        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}

// MARK: - Home
extension ReminderFlowController: HomeFlowDelegate {
    func navigateToRecipes() {
        let recipesViewController = viewControllerFactory.makeNewReceiptController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(recipesViewController, animated: true)

    }

    func navigateToMyReceipts() {
        let myReceiptsViewController = viewControllerFactory.makeMyReceiptsViewController(flowDelegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(myReceiptsViewController, animated: true)
    }

    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.openLoginBottomSheet()
    }

}

// MARK: - MyReceipts
extension ReminderFlowController: MyReceiptsViewFlowDelegate {
    func navigateToAddReceipt() {
        let recipesViewController = viewControllerFactory.makeNewReceiptController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(recipesViewController, animated: true)
    }
}
