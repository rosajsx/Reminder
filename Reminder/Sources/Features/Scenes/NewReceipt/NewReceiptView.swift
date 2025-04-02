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
        button.backgroundColor = button.isEnabled ? Colors.primaryRedBase : Colors.gray500
        button.layer.cornerRadius = 12
        button.setTitleColor(Colors.gray800, for: .normal)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let remedyInput = Input(title: "Remédio", placeholder: "Nome do medicamento")
    let timeInput = Input(title: "Horário", placeholder: "12:00")
    let recurrencyInput = Input(title: "Recorrência", placeholder: "Selecione")
    let takeNowCheckbox = Checkbox(title: "Tomar agora")

    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    let recurrencyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    let recurrencyOptions = [
        "De hora em hora",
        "2 em 2 horas",
        "4 em 4 horas",
        "6 em 6 horas",
        "8 em 8 horas",
        "12 em 12 horas",
        "Um por dia"
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(remedyInput)
        addSubview(timeInput)
        addSubview(recurrencyInput)
        addSubview(takeNowCheckbox)
        addSubview(addButton)

        setupTimeInput()
        setupObservers()
        setupRecurrencyInput()
        validateInputs()
        setupConstraints()
    }

    private func setupConstraints() {
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

    private func setupTimeInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectTime))

        toolbar.setItems([doneButton], animated: true)

        timeInput.textField.inputView = timePicker
        timeInput.textField.inputAccessoryView = toolbar
    }

    private func setupRecurrencyInput() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didSelectRecurrency))
        toolbar.setItems([doneButton], animated: true)

        recurrencyInput.textField.inputView = recurrencyPicker
        recurrencyInput.textField.inputAccessoryView = toolbar

        recurrencyPicker.delegate = self
        recurrencyPicker.dataSource = self
    }

    private func validateInputs() {
        let isRemedyFilled = !(remedyInput.textField.text ?? "").isEmpty
        let isTimeFilled = !(timeInput.textField.text ?? "").isEmpty
        let isRecurrencyFilled = !(recurrencyInput.textField.text ?? "").isEmpty

        addButton.isEnabled = isRemedyFilled && isTimeFilled && isRecurrencyFilled
        addButton.backgroundColor = addButton.isEnabled ? Colors.primaryRedBase : Colors.gray500
    }

    private func setupObservers() {
        remedyInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        timeInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        recurrencyInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }

    @objc
    private func inputDidChange() {
        validateInputs()
    }

    @objc
    private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePicker.date)
        timeInput.textField.resignFirstResponder() // Atualizar e falar que eu terminei aquela ação.

        validateInputs()
    }

    @objc
    private func didSelectRecurrency() {
        let selectedRow = recurrencyPicker.selectedRow(inComponent: 0)
        recurrencyInput.textField.text = recurrencyOptions[selectedRow]

        recurrencyInput.textField.resignFirstResponder()

        validateInputs()

    }

}

extension NewReceiptView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurrencyOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recurrencyOptions[row]
    }
}
