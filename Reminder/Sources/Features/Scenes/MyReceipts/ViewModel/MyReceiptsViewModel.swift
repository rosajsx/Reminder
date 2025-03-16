//
//  MyReceiptsViewModel.swift
//  Reminder
//
//  Created by Lucas Rosa  on 14/03/25.
//

import Foundation
import UserNotifications


class MyReceiptsViewModel {
    func fetchData() -> [Medicine] {
        return DBHelper.shared.fetchReceipts()
    }
    
    func deleteReceipt(byId id: Int) {
         DBHelper.shared.deleteReceipt(byId: id)

    }
    
    func removeNotifications(for remedy: String) {
        let center = UNUserNotificationCenter.current()
        let identifiers = (0..<6).map { "\(remedy)-\($0)" }
        
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        print("Notificações para \(remedy) removidas!")
        
    }
}
