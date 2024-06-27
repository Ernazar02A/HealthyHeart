//
//  
//  ConfirmNumberViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 24/6/24.
//
//

import UIKit
import SnapKit

protocol ConfirmNumberScreen: AnyObject {
    var presenter: IConfirmNumberPresenter! { get set }
}

typealias IConfirmNumberViewController = BaseViewController & ConfirmNumberScreen

final class ConfirmNumberViewController: IConfirmNumberViewController {
    
    private let titleLabel: UILabel = {
        let view = UILabel(font: .h28Bold)
        view.textAlignment = .center
        return view
    }()
    
    private let bodyLabel: UILabel = {
        let view = UILabel(font: .h17Regular)
        view.textAlignment = .center
        return view
    }()
    
    private let numberLabel: UILabel = {
        let view = UILabel(font: .h17SemiBold)
        view.textAlignment = .center
        return view
    }()
    
    private let codeTextField = MainTextField(style: .init(
        placeholder: "Введите код",
        title: "Код  ",
        keyboardType: .numberPad)
    )
    
    private let confirmButton = MainButton(isActive: true)
    
    private let resendButton = ResendButton()
    
    var presenter: IConfirmNumberPresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        resendButton.addTarget(self, action: #selector(resendCode), for: .touchUpInside)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.add {
            titleLabel
            bodyLabel
            codeTextField
            numberLabel
            confirmButton
            resendButton
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
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(heightComputed(12))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(heightComputed(24))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        confirmButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.top.equalTo(codeTextField.snp.bottom).offset(heightComputed(24))
            make.height.equalTo(heightComputed(50))
        }
        
        resendButton.snp.makeConstraints { make in
            make.top.equalTo(confirmButton.snp.bottom).offset(heightComputed(28))
            make.centerX.equalToSuperview()
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        view.backgroundColor = themeProperties.bgPrimary
        titleLabel.textColor = themeProperties.labelPrimary
        bodyLabel.textColor = themeProperties.labelSecondary
        numberLabel.textColor = themeProperties.blue
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        navigationItem.title = "Подтверждение"
        confirmButton.setTitle("Продолжит", for: .normal)
        titleLabel.text = "Введите код из СМС"
        bodyLabel.text = "Мы отправили вам код на номер"
    }
    
    @objc
    private func confirmTapped(_ sender: UIButton) {
        sender.animationTapButton()
        guard let codeText = codeTextField.textField.text else { return }
        if codeText.isEmpty {
            codeTextField.setupErrorBorder(with: "Пустое поле")
        } else {
            presenter.confirmCode(code: codeText)
            codeTextField.removerErrorBorder()
        }
    }
    
    @objc
    private func resendCode() {
        presenter.resendCode()
    }
}

//MARK: - IConfirmNumberDelegate
extension ConfirmNumberViewController: IConfirmNumberDelegate {
    
    func reStartTimer() {
        resendButton.resetTimer()
    }
    
    func showErrorCode() {
        codeTextField.showErrorTitle(title: "Не правильный код", isVisible: true)
    }
    
    func setNumber(number: String) {
        numberLabel.text = "\(number)"
    }
}
