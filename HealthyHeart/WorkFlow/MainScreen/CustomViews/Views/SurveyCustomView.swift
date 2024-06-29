//
//  SurveyCustomView.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit
import SnapKit

class SurveyCustomView: BaseView {
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "medCard")
        return image
    }()
    
    private let surveyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let takeASurveyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 17
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapToSurvey), for: .touchUpInside)
        return button
    }()
    
    override func setup() {
        super.setup()
        viewStyle()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            iconImageView
            surveyTitleLabel
            descriptionLabel
            takeASurveyButton
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(heightComputed(12))
            make.leading.equalToSuperview().offset(widthComputed(16))
            make.height.equalTo(heightComputed(56))
            make.width.equalTo(widthComputed(56))
        }
        
        surveyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(heightComputed(8))
            make.directionalHorizontalEdges.equalTo(widthComputed(16))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(surveyTitleLabel.snp.bottom).offset(heightComputed(8))
            make.directionalHorizontalEdges.equalTo(widthComputed(16))
        }
        
        takeASurveyButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(heightComputed(8))
            make.leading.equalToSuperview().offset(widthComputed(16))
            make.trailing.equalToSuperview().offset(widthComputed(-16))
            make.height.equalTo(heightComputed(34))
            make.bottom.equalTo(heightComputed(-12))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        backgroundColor = themeProperties.bgGraySecondary
        surveyTitleLabel.textColor = themeProperties.labelPrimary
        descriptionLabel.textColor = themeProperties.labelSecondary
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        surveyTitleLabel.text = "Пройдите опрос"
        descriptionLabel.text = "Ответьте на несколько вопросов чтобы мы могли давать более релевантные советы"
        takeASurveyButton.setTitle("Пройти опрос", for: .normal)
    }
    
    @objc private func tapToSurvey(_ sender: UIButton) {
        
    }
    
    private func viewStyle() {
        layer.cornerRadius = 12
    }
}
