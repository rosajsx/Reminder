//
//  NewReceipt.swift
//  Reminder
//
//  Created by Lucas Rosa  on 03/02/25.
//

import Foundation
import UIKit
import Lottie

class NewReceiptController: UIViewController {
    private let newReceiptView = NewReceiptView()
    private let viewModel = NewReceiptViewModel()

    private let successAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true

        return animationView
    }()

    override func viewDidLoad() {

        super.viewDidLoad()
        setupView()
        setupActions()
    }

    private func setupView() {
        view.backgroundColor = Colors.gray800
        view.addSubview(newReceiptView)
        view.addSubview(successAnimationView)
        self.navigationItem.hidesBackButton = true
        setupConstraints()
    }

    private func setupActions() {
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newReceiptView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    private func setupConstraints() {
        setupContentViewToBounds(contentView: newReceiptView)
        NSLayoutConstraint.activate([
            successAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
    }

    func clearFields() {
        newReceiptView.remedyInput.textField.text = ""
        newReceiptView.recurrencyInput.textField.text = ""
        newReceiptView.timeInput.textField.text = ""
        newReceiptView.addButton.isEnabled = false
    }

    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    private func addButtonTapped() {
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

        playSuccessAnimation()
        print("Receita \(remedy) adicionada")
    }

    private func playSuccessAnimation() {
        successAnimationView.isHidden = false
        successAnimationView.play { [weak self] finished in
            if finished {
                self?.clearFields()
                self?.successAnimationView.isHidden = true
            }
        }
    }

}
