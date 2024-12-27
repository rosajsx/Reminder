//
//  LoginBottomSheetView.swift
//  Reminder
//
//  Created by Lucas Rosa  on 23/12/24.
//

import Foundation
import UIKit

class LoginBottomSheetView: UIView {
    
    public weak var delegate: LoginBottomSheetViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "login.label.title".localized
       // label.isUserInteractionEnabled = true Por padrão vem desabilitado em vários componente, mas com isso podemos adicionar gestos.
        label.font = Typography.subHeading
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let handleArea: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Metrics.tiny
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "login.email.label".localized
        label.font = Typography.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: PaddedTextField = {
        let text = PaddedTextField()
        text.setPadding(newPadding: UIEdgeInsets(top: 18.5, left: 16, bottom: 18.5, right: 16))
        text.textColor = Colors.gray200
        
        text.attributedPlaceholder = NSAttributedString(string: "login.email.placeholder".localized, attributes: [NSAttributedString.Key.foregroundColor: Colors.gray200])
        text.autocapitalizationType = .none
        
        text.font = Typography.input
        text.borderStyle = .roundedRect
        text.layer.borderWidth = 1.0
        text.layer.borderColor = Colors.gray400.cgColor
        text.layer.cornerRadius = Metrics.tiny
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        
    
        return text
    }()
    
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "login.password.label".localized
        label.font = Typography.label

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: PaddedTextField = {
        let text = PaddedTextField()
        text.setPadding(newPadding: UIEdgeInsets(top: 18.5, left: 16, bottom: 18.5, right: 16))
        text.font = Typography.input

        text.attributedPlaceholder = NSAttributedString(string: "login.password.placeholder".localized, attributes: [NSAttributedString.Key.foregroundColor: Colors.gray200])
        text.borderStyle = .roundedRect
        text.layer.borderWidth = 1.0
        text.layer.borderColor = Colors.gray400.cgColor
        text.layer.cornerRadius = Metrics.tiny
        
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let passwordTextFieldEyeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eye")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login.button.title".localized, for: .normal)
        button.tintColor = Colors.gray800
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = Metrics.medium
        button.titleLabel?.font = Typography.subHeading
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        //let exampleGest = UITapGestureRecognizer(target: self, action: #selector(exampleTap))
        //titleLabel.addGestureRecognizer(exampleGest)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc
//    private func exampleTap(){
//        print("click label")
//    }
    
    
    private func setupUI(){
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.medium
        
       // addSubview(handleArea)
        addSubview(titleLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        passwordTextField.addSubview(passwordTextFieldEyeIcon)
        addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
//            handleArea.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),
//            handleArea.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            handleArea.widthAnchor.constraint(equalToConstant: Metrics.veryLarge),
//            handleArea.heightAnchor.constraint(equalToConstant: 6),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.large),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
            
            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.veryLarge),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Metrics.small),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),

            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Metrics.small),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
            
            passwordTextFieldEyeIcon.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordTextFieldEyeIcon.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),

            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.large),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.large),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.huge),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize)
            
            
        ])
        
    }
    
    @objc
    private func loginButtonDidTapped(){
        let password = passwordTextField.text ?? ""
        let user = emailTextField.text ?? ""
        
        delegate?.sendLoginData(user: user, password: password)
    }
}
