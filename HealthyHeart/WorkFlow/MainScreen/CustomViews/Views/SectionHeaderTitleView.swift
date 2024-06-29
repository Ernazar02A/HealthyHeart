//
//  SectionHeaderTitleView.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit

class SectionHeaderTitleView: BaseCollectionReusableView {
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .semibold)
        return label
    }()
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            headerTitle
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerTitle.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTitle(title: String, color: UIColor) {
        headerTitle.text = title
        headerTitle.textColor = color
    }
}
