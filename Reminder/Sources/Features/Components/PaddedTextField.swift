//
//  PaddedTextField.swift
//  Reminder
//
//  Created by Lucas Rosa  on 24/12/24.
//

import Foundation
import UIKit

class PaddedTextField: UITextField {
    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    func setPadding(newPadding: UIEdgeInsets) {
        self.padding = newPadding
    }

}
