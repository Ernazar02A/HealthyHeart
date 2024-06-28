//
//  InputTableViewCell.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//

import UIKit

protocol InputTableViewCellDelegate: AnyObject {
    func setText(index: Int, text: String)
}

final class InputTableViewCell: BaseTableViewCell {

    private let titleLabel = UILabel(font: .h17Regular)
    
    private lazy var inputTextField: UITextField = {
        let view = UITextField()
        view.autocapitalizationType = .none
        view.addTarget(self, action: #selector(changeValueText), for: .editingChanged)
        return view
    }()
    
    var delegate: InputTableViewCellDelegate?
        
    override func setupSubviews() {
        super.setupSubviews()
        contentView.add {
            titleLabel
            inputTextField
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(135)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(widthComputed(10))
            make.trailing.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        backgroundColor = themeProperties.bgPrimary
        contentView.backgroundColor = themeProperties.bgPrimary
        titleLabel.textColor = themeProperties.labelPrimary
    }
    
    @objc
    private func changeValueText(textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.setText(index: tag, text: text)
    }
    
    func fill(with item: InputModel, index: Int) {
        self.tag = index
        inputTextField.isEnabled = item.isEnable
        inputTextField.keyboardType = item.keyboardType
        inputTextField.placeholder = item.placeholder
        titleLabel.text = item.title
        if !item.text.isEmpty {
            inputTextField.text = item.text
        } else {
            inputTextField.text = nil
        }
    }
}
