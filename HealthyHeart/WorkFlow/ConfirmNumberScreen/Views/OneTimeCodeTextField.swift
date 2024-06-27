//
//  OneTimeCodeTextField.swift
//  HealthyHeart
//
//  Created by Ernazar on 25/6/24.
//

import UIKit

//final class OneTimeCodeTextField: UITextField {
//    
//    var didEnterDigit: ((String) -> Void)?
//    
//    private var isConfigured = false
//    
//    private var digitLabels = [UILabel]()
//    
//    var defaultCharacter = "-"
//    
//    private lazy var tapRecognizer: UITapGestureRecognizer = {
//        let view = UITapGestureRecognizer()
//        view.addTarget(self, action: #selector(becomeFirstResponder))
//        return view
//    }()
//    
//    func configure(with slotCount: Int = 6) {
//        guard isConfigured == false else { return }
//        isConfigured.toggle()
//        configureTextField()
//        
//        let labelsStackView = createLabelStackView(with: slotCount)
//        addSubview(labelsStackView)
//        
//        addGestureRecognizer(tapRecognizer)
//        labelsStackView.snp.makeConstraints { make in
//            make.directionalEdges.equalToSuperview()
//        }
//    }
//    
//    private func configureTextField() {
//        textColor = .clear
//        tintColor = .clear
//        keyboardType = .numberPad
//        textContentType = .oneTimeCode
//        
//        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
//        delegate = self
//    }
//    
//    private func createLabelStackView(with count: Int) -> UIStackView {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
//        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
//        stackView.spacing = 4
//        
//        for _ in 1 ... count {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.textAlignment = .center
//            label.layer.cornerRadius = 8
//            label.layer.borderWidth = 1
//            label.textColor = Theme.shared.lightGrayishBlueColor
//            label.layer.borderColor = Theme.shared.lightGrayishBlueColor.cgColor
//            label.font = .custom(with: 48)
//            label.isUserInteractionEnabled = true
//            label.text = defaultCharacter
//            stackView.addArrangedSubview(label)
//            
//            digitLabels.append(label)
//            digitLabelStates.append(DigitLabelState(text: nil, borderColor: Theme.shared.lightGrayishBlueColor, textColor: Theme.shared.lightGrayishBlueColor))
//        }
//        
//        return stackView
//    }
//    
//    func setupError() {
//        digitLabels.forEach { label in
//            label.layer.borderColor = Theme.shared.redOrangeColor.cgColor
//        }
//    }
//    
//    struct DigitLabelState {
//        var text: String?
//        var borderColor: UIColor
//        var textColor: UIColor
//    }
//    
//    private var digitLabelStates = [DigitLabelState]()
//    
//    @objc private func textDidChange() {
//        
//        guard let text = self.text, text.count <= digitLabels.count else { return }
//        
//        for i in 0 ..< digitLabels.count {
//            let state = DigitLabelState(
//                text: i < text.count ? String(text[text.index(text.startIndex, offsetBy: i)]) : defaultCharacter,
//                borderColor: i < text.count ? Theme.shared.skyBlueColor : Theme.shared.lightGrayishBlueColor,
//                textColor: i < text.count ? Theme.shared.skyBlueColor : Theme.shared.lightGrayishBlueColor
//            )
//            digitLabelStates[i] = state
//        }
//        
//        updateDigitLabels()
//        didEnterDigit?(text)
//    }
//    
//    private func updateDigitLabels() {
//        for (label, state) in zip(digitLabels, digitLabelStates) {
//            label.text = state.text
//            label.layer.borderColor = state.borderColor.cgColor
//            label.textColor = state.textColor
//        }
//    }
//}
//
////MARK: - UITextFieldDelegate
//extension OneTimeCodeTextField: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let newLength = (textField.text?.count ?? 0) + string.count - range.length
//        return newLength <= digitLabels.count || string == ""
//    }
//}
//
