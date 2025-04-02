//
//  HomeView.swift
//  Reminder
//
//  Created by Lucas Rosa on 07/01/25.
//

import Foundation
import UIKit

class HomeView: UIView {

    weak public var delegate: HomeViewDelegate?

    let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let contentBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.medium
        view.layer.masksToBounds = true
        view.backgroundColor = Colors.gray800
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    let profileImage: UIImageView = {
        let image = UIImageView()

        image.isUserInteractionEnabled = true
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = Metrics.medium
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.input
        label.text = "home.welcome.label".localized
        label.textColor = Colors.gray200

        return label
    }()

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = Typography.heading
        textField.textColor = Colors.gray100
        textField.placeholder = "Insira seu nome"
        textField.returnKeyType = .done

        return textField
    }()

    let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("home.feedback.button.title".localized, for: .normal)
        button.backgroundColor = Colors.gray100
        button.layer.cornerRadius = Metrics.medium
        button.setTitleColor(Colors.gray800, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let myPrescription: ButtonHomeView = {
        let button = ButtonHomeView(icon: UIImage(named: "Paper"), title: "Minhas receitas", description: "Acompanhe os medicamentos e gerencie lembretes")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let newPrescription: ButtonHomeView = {
        let button = ButtonHomeView(icon: UIImage(named: "pills"), title: "Nova receita", description: "Cadastre novos lembretes de receitas")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(nameTextField)

        addSubview(contentBackground)
        contentBackground.addSubview(feedbackButton)
        contentBackground.addSubview(myPrescription)
        contentBackground.addSubview(newPrescription)
        setupConstraints()
        setupImageGesture()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
             profileBackground.heightAnchor.constraint(equalToConstant: Metrics.backgroundProfileSize),
             profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
             profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),

            profileImage.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: Metrics.huge),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.medium),
            profileImage.heightAnchor.constraint(equalToConstant: Metrics.profileImageSize),
            profileImage.widthAnchor.constraint(equalToConstant: Metrics.profileImageSize),

            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.small),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),

            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.little),
            nameTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),

            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),

            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.medium),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),

            myPrescription.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.huge),
            myPrescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            myPrescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            myPrescription.heightAnchor.constraint(equalToConstant: 112),

            newPrescription.topAnchor.constraint(equalTo: myPrescription.bottomAnchor, constant: Metrics.medium),
            newPrescription.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            newPrescription.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            newPrescription.heightAnchor.constraint(equalTo: myPrescription.heightAnchor)

        ])

    }

    private func setupImageGesture() {
        let tapGestureRegognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))

        profileImage.addGestureRecognizer(tapGestureRegognizer)
    }

    private func setupTextField() {
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidEndEditing), for: .editingDidEnd)
        nameTextField.delegate = self
    }

    @objc
    private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }

    @objc
    private func nameTextFieldDidEndEditing() {
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(name: userName)
    }

}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(name: userName)
        return true
    }
}
