//
//  ViewControllersFactoryProtocol.swift
//  Reminder
//
//  Created by Lucas Rosa  on 03/01/25.
//

import Foundation


protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSplashViewController(flowDelegate: SplashViewFlowDelegate) -> SplashViewController
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
}
