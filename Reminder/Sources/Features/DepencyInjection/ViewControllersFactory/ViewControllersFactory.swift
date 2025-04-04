//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Lucas Rosa  on 03/01/25.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeNewReceiptController() -> NewReceiptController {
        let viewController = NewReceiptController()
        return viewController
    }

    func makeSplashViewController(flowDelegate: SplashViewFlowDelegate) -> SplashViewController {
        let contentView = SplashView()
        let viewController = SplashViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }

    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }

    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView, flowDelegate: flowDelegate)

        return viewController
    }

    func makeMyReceiptsViewController(flowDelegate: MyReceiptsViewFlowDelegate) -> MyReceiptsViewController {
        let contentView = MyReceiptsView()
        let viewController = MyReceiptsViewController(contentView: contentView, flowDelegate: flowDelegate)

        return viewController
    }

}
