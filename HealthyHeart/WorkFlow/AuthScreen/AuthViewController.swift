//
//  
//  AuthViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import UIKit
import SnapKit

protocol AuthScreen: AnyObject {
    var presenter: IAuthPresenter! { get set }
}

typealias IAuthViewController = BaseViewController & AuthScreen

final class AuthViewController: IAuthViewController {
    
    private let titleLabel: UILabel = {
        let view = UILabel(font: .h28Bold)
        view.numberOfLines = 3
        view.textAlignment = .center
        return view
    }()
    
    private let bodyLabel: UILabel = {
        let view = UILabel(font: .h17Regular)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    private let numberTextField = MainTextField(style: .init(placeholder: "+996", title: "Номер телефона ", keyboardType: .numberPad))
    
    private let authButton = MainButton(isActive: false)
    
    var presenter: IAuthPresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
        numberTextField.textField.becomeFirstResponder()
        numberTextField.textField.delegate = self
        authButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.add {
            titleLabel
            bodyLabel
            numberTextField
            authButton
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(heightComputed(111))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(heightComputed(12))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(heightComputed(24))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        authButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.top.equalTo(numberTextField.snp.bottom).offset(heightComputed(24))
            make.height.equalTo(heightComputed(50))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        view.backgroundColor = themeProperties.bgPrimary
        titleLabel.textColor = themeProperties.labelPrimary
        bodyLabel.textColor = themeProperties.labelSecondary
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        authButton.setTitle("Войти", for: .normal)
        titleLabel.text = "Войдите в систему"
        navigationController?.title = "Вход"
        numberTextField.textField.text = "+996 "
        bodyLabel.text = "Для входа введите свой номер, на который мы отправим код подтверждения"
    }
    
    @objc
    private func signInTapped(_ sender: UIButton) {
        sender.animationTapButton()
        guard let numberText = numberTextField.textField.text else { return }
        presenter.auth(number: numberText)
    }
}

//MARK: - IAuthDelegate
extension AuthViewController: IAuthDelegate {
    
}

//MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        if range.location < 4 {
            return false
        }
        let newText = currentText.replacingCharacters(in: range, with: string)
        let formatText = format(with: "+XXX XXX XX XX XX", phone: newText)
        textField.text = formatText
        authButton.changeActiveBackgroundButton(state: isValidPhoneNumber(formatText))
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = "+996 "
        }
    }
    
    private func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^\\+996\\s[0-9]{3}\\s[0-9]{2}\\s[0-9]{2}\\s[0-9]{2}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
}
