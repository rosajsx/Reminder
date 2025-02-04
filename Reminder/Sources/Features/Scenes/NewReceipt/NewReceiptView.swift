//
//  NewReceiptView.swift
//  Reminder
//
//  Created by Lucas Rosa  on 03/02/25.
//

import Foundation
import UIKit



class NewReceiptView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.gray100
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.heading
        label.textColor = Colors.primaryRedBase
        label.text = "Nova receita"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.text = "Adicione a sua prescrição médica para receber lembretes de quando tomar seu medicamento"
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 12
        button.setTitleColor(Colors.gray800, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    let remedyInput = Input(title: "Remédio", placeholder: "Nome do medicamento")
    let timeInput = Input(title: "Horário", placeholder: "12:00")
    let recurrencyInput = Input(title: "Recorrência", placeholder: "Selecione")
    let takeNowCheckbox = Checkbox(title: "Tomar agora")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(remedyInput)
        addSubview(timeInput)
        addSubview(recurrencyInput)
        addSubview(takeNowCheckbox)
        addSubview(addButton)
        setupConstraints()
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            remedyInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.medium),
            remedyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            remedyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            timeInput.topAnchor.constraint(equalTo: remedyInput.bottomAnchor, constant: Metrics.medium),
            timeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            timeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            recurrencyInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.medium),
            recurrencyInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            recurrencyInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            takeNowCheckbox.topAnchor.constraint(equalTo: recurrencyInput.bottomAnchor, constant: Metrics.medium),
            takeNowCheckbox.leadingAnchor.constraint(equalTo: recurrencyInput.leadingAnchor),
            takeNowCheckbox.trailingAnchor.constraint(equalTo: recurrencyInput.trailingAnchor),
            
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.large)
        ])
    }
    
    
}
