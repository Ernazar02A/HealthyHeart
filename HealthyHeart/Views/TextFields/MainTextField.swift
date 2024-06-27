//
//  MainTextField.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 14/6/24.
//

import UIKit

final class MainTextField: BaseView {
    
    struct TextFieldModel {
        let placeholder: String
        let title: String?
        let rightViewImage: UIImage?
        let keyboardType: UIKeyboardType
        let isSecureTextEntry: Bool?
        let exampleDescriptionTitle: String?
        
        init(
            placeholder: String,
            title: String? = nil,
            rightViewImage: UIImage? = nil,
            keyboardType: UIKeyboardType = .default,
            isSecureTextEntry: Bool? = false,
            exampleDescriptionTitle: String? = nil
        ) {
            self.placeholder = placeholder
            self.title = title
            self.rightViewImage = rightViewImage
            self.keyboardType = keyboardType
            self.isSecureTextEntry = isSecureTextEntry
            self.exampleDescriptionTitle = exampleDescriptionTitle
        }
    }
    
    private let title = UILabel(font: .h17Regular)
    
    private let errorTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .h17Regular
        view.isHidden = false
        view.numberOfLines = 3
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: view.frame.height))
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: view.frame.height))
        rightViewContainer.addSubview(rightImageButton)
        view.rightView = rightViewContainer
        view.leftViewMode = .always
        view.rightViewMode = .always
        view.textContentType = .username
        view.autocapitalizationType = .none
        view.layer.cornerRadius = 8
        view.delegate = self
        return view
    }()
    
    lazy var rightImageButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(onRightImageTap), for: .touchUpInside)
        return view
    }()
    
    private let leftLabelView = UILabel(font: .h17Regular)
    
    var onButtonPress: ((MainTextField) -> Void)?
    var onChangeText: ((String) -> Void)?
    var didBeginEditing: ((UITextField) -> Void)?
    
    var isSecureTextEntry: Bool {
        get { textField.isSecureTextEntry }
        set { textField.isSecureTextEntry = newValue }
    }
    
    var text: String {
        textField.text ?? ""
    }
    
    init(style: TextFieldModel) {
        super.init(frame: .zero)
        setup()
        configureTextField(with: style)
        configureImageView(with: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            title
            textField
            rightImageButton
            errorTitleLabel
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(heightComputed(8))
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        rightImageButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.height.width.equalTo(60)
        }
        
        errorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(heightComputed(5))
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(heightComputed(0))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        //title.textColor = themeProperties.textDarkDefault
        textField.backgroundColor = .clear
        leftLabelView.textColor = themeProperties.labelPrimary
        //textField.layer.borderColor = themeProperties.textDarkDefault.cgColor
        errorTitleLabel.textColor = .systemRed
    }
    
    func setupErrorBorder(with text: String = "") {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        if !text.isEmpty {
            errorTitleLabel.text = text
        }
    }
    
    func showErrorTitle(title: String, isVisible: Bool) {
        errorTitleLabel.text = title
        errorTitleLabel.isHidden = !isVisible
    }
    
    func removerErrorBorder() {
        textField.layer.borderWidth = 0
        errorTitleLabel.text = ""
        errorTitleLabel.numberOfLines = 3
    }
    
    func setText(_ text: String?) {
        textField.text = text
    }
    
    func displayError(title: String, isVisible: Bool) {
        errorTitleLabel.text = title
        errorTitleLabel.isHidden = !isVisible
        if isVisible {
            setupErrorBorder(with: title)
        } else {
            removerErrorBorder()
        }
    }
    
    func clearError() {
        textField.layer.borderWidth = 0
        errorTitleLabel.text = ""
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        textField.addTarget(target, action: action, for: controlEvents)
    }
    
    @objc
    private func onRightImageTap() {
        onButtonPress?(self)
    }
    
    private func configureImageView(with item: TextFieldModel) {
        if let image = item.rightViewImage {
            rightImageButton.setImage(image, for: .normal)
            textField.rightView = rightImageButton
            textField.rightViewMode = .always
        } else {
            rightImageButton.removeFromSuperview()
            textField.rightView = nil
            textField.rightViewMode = .never
        }
    }
    
    private func configureTextField(with item: TextFieldModel) {
        leftLabelView.text = item.title
        textField.leftView = leftLabelView
        textField.placeholder = item.placeholder
        textField.rightViewMode = .always
        textField.isSecureTextEntry = item.isSecureTextEntry ?? false
        textField.keyboardType = item.keyboardType
        textField.placeholder = item.placeholder
        textField.isSecureTextEntry = item.isSecureTextEntry ?? false
    }
}

//MARK: - UITextFieldDelegate
extension MainTextField: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        onChangeText?(text)
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.layer.borderWidth = 2
//        didBeginEditing?(textField)
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        textField.layer.borderWidth = 0
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
