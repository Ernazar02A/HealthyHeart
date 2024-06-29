//
//  SectionSmallHeaderView.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit
import SnapKit

class SectionSmallHeaderView: BaseCollectionReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            titleLabel
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func applyThemeProperties(_ themeProperties: ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        titleLabel.textColor = themeProperties.labelPrimary
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
