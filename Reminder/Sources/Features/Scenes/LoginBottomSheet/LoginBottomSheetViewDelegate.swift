//
//  LoginBottomSheetViewDelegate.swift
//  Reminder
//
//  Created by Lucas Rosa  on 24/12/24.
//

import Foundation
import UIKit
// Contrato responsavel pela comunicação entre View e Controller
protocol LoginBottomSheetViewDelegate: AnyObject {
    func sendLoginData(user: String, password: String)

}
