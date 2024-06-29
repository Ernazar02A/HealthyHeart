//
//  SurveyCollectionViewCell.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit
import SnapKit

class SurveyCollectionViewCell: BaseCollectionViewCell {
    
    private let surveyCustomView = SurveyCustomView()
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            surveyCustomView
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        surveyCustomView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        
    }
}
