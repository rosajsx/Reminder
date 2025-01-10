//
//  HomeFlowDelegate.swift
//  Reminder
//
//  Created by Lucas Rosa on 07/01/25.
//

import Foundation


public protocol HomeFlowDelegate: AnyObject {
    func navigateToRecipes()
    func logout()
}
