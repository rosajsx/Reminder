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
    private let viewModel = NewReceiptViewModel()
    
    
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
        newReceiptView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        setupContentViewToBounds(contentView: newReceiptView)
    }
    
    @objc
    private func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func addButtonTapped(){
        // se tivesse sido com input normal
        // guard let remedy = newReceiptview.remedyInput.text
        // else { print("input não válido")}
        let remedy = newReceiptView.remedyInput.getText()
        let time  = newReceiptView.timeInput.getText()
        let recurrency = newReceiptView.recurrencyInput.getText()
        let takeNow = false
        
        viewModel.addReceipt(remedy: remedy,
                             time: time,
                             recurrency: recurrency,
                             takeNow: takeNow)
        
        print("Receita \(remedy) adicionada")
    }
    
}
