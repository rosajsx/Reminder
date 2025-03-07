//
//  MyReceiptsView.swift
//  Reminder
//
//  Created by Lucas Rosa  on 07/03/25.
//

import Foundation
import UIKit


class MyReceiptsView: UIView {
   weak public var delegate: MyReceiptsViewDelegate?
    
    let headerBgackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    let backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "arrow-left")
        
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primaryBlueBase
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "add-button")
        
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primaryBlueBase
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas receitas"
        label.font = Typography.heading
        label.textColor = Colors.primaryBlueBase
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Acompanhe seus medicamentos cadastrados e gerencie lembretes"
        label.font = Typography.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.medium
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray800
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(headerBgackground)
        headerBgackground.addSubview(backButton)
        headerBgackground.addSubview(addButton)
        headerBgackground.addSubview(titleLabel)
        headerBgackground.addSubview(subTitleLabel)
        addSubview(contentBackground)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            headerBgackground.topAnchor.constraint(equalTo: topAnchor),
            headerBgackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBgackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBgackground.heightAnchor.constraint(equalToConstant: Metrics.backgroundProfileSize),
            
            backButton.leadingAnchor.constraint(equalTo: headerBgackground.leadingAnchor, constant: Metrics.medium),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            addButton.trailingAnchor.constraint(equalTo: headerBgackground.trailingAnchor, constant: -Metrics.medium),
            addButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.leadingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.trailingAnchor.constraint(equalTo: headerBgackground.trailingAnchor, constant: -Metrics.medium),
            
            
            contentBackground.topAnchor.constraint(equalTo: headerBgackground.bottomAnchor, constant: -Metrics.small),
            contentBackground.leadingAnchor.constraint(equalTo: headerBgackground.leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: headerBgackground.trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    @objc
    private func didTapBackButton(){
        delegate?.didTapBackButton()
    }
    
    @objc
    private func didTapAddButton(){
        delegate?.didTapAddButton()
    }
    
}


protocol MyReceiptsViewDelegate: AnyObject {
    
    func didTapBackButton()
    
    func didTapAddButton()
    
}
