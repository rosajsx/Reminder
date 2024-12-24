//
//  String+Ext.swift
//  Reminder
//
//  Created by Lucas Rosa  on 24/12/24.
//

import Foundation


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
