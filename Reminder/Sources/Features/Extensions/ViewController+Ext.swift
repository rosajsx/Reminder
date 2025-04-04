//
//  ViewController+Ext.swift
//  Reminder
//
//  Created by Lucas Rosa on 07/01/25.
//

import Foundation
import UIKit

extension UIViewController {

    func setupContentViewToBounds(contentView: UIView, isTopSafe: Bool? = true) {
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: isTopSafe! ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
