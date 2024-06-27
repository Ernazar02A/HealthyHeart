//
//  
//  SuccessfulLoginViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import UIKit
import SnapKit

protocol SuccessfulLoginScreen: AnyObject {
    var presenter: ISuccessfulLoginPresenter! { get set }
}

typealias ISuccessfulLoginViewController = BaseViewController & SuccessfulLoginScreen

final class SuccessfulLoginViewController: ISuccessfulLoginViewController {
    
    private let imageView = UIImageView(image: .success)
    
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
    
    private let inputButton = MainButton(isActive: true)
    
    var presenter: ISuccessfulLoginPresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
        inputButton.addTarget(self, action: #selector(inputTapped), for: .touchUpInside)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.add {
            imageView
            titleLabel
            bodyLabel
            inputButton
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(heightComputed(30))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.height.equalTo(heightComputed(345))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(heightComputed(40))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(heightComputed(12))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        inputButton.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(heightComputed(32))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.height.equalTo(heightComputed(50))
        }
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        titleLabel.text = "Вы успешно вошли в систему!"
        bodyLabel.text = "Заполните свои данные чтобы мы могли давать рекомендации и советы по поводу вашего здоровья"
        inputButton.setTitle("Заполнить", for: .normal)
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        view.backgroundColor = themeProperties.bgPrimary
        titleLabel.textColor = themeProperties.labelPrimary
        bodyLabel.textColor = themeProperties.labelSecondary
    }
    
    @objc
    private func inputTapped(_ sender: UIButton) {
        sender.animationTapButton()
        presenter.showInputScreen()
    }
}

//MARK: - ISuccessfulLoginDelegate
extension SuccessfulLoginViewController: ISuccessfulLoginDelegate {
    
}
