//
//  InputHeaderView.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//


import UIKit

final class InputHeaderView: BaseView {
    
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
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            titleLabel
            bodyLabel
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(heightComputed(24))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(heightComputed(12))
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.bottom.equalToSuperview().offset(heightComputed(-12))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        backgroundColor = themeProperties.bgPrimary
        titleLabel.textColor = themeProperties.labelPrimary
        bodyLabel.textColor = themeProperties.labelSecondary
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        titleLabel.text = "Заполните анкету"
        bodyLabel.text = "Для более корректного отображения информации введите свои данные"
    }
}
