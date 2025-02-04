//
//  NewReceipt.swift
//  Reminder
//
//  Created by Lucas Rosa  on 03/02/25.
//

import Foundation
import UIKit


class NewReceiptController: UIViewController {
    private let newReceiptView = NewReceiptView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    private func setupView(){
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        
        setupConstraints()
    }
    
    private func setupActions(){
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        setupContentViewToBounds(contentView: newReceiptView)
    }
    
    @objc
    private func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
