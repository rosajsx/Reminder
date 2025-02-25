//
//  NewReceiptViewModel.swift
//  Reminder
//
//  Created by Lucas Rosa  on 20/02/25.
//

import Foundation

class NewReceiptViewModel {
    func addReceipt(remedy: String, time: String, recurrency: String, takeNow: Bool){
        DBHelper.shared.insertReceipt(remedy: remedy, time: time, recurrency: recurrency, takeNow: takeNow)
    }
}
