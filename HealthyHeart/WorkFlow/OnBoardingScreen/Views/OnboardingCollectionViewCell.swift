//
//  OnboardingCollectionViewCell.swift
//  HealthyHeart
//
//  Created by Ernazar on 23/6/24.
//

import UIKit

final class OnboardingCollectionViewCell: BaseCollectionViewCell {
    
    private let imageView = UIImageView()
    
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
        contentView.add {
            imageView
            titleLabel
            bodyLabel
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(heightComputed(50))
            make.centerX.equalToSuperview()
            make.height.equalTo(heightComputed(305))
            make.width.equalTo(widthComputed(305))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(heightComputed(20))
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(heightComputed(12))
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        titleLabel.textColor = themeProperties.labelPrimary
        bodyLabel.textColor = themeProperties.labelSecondary
    }
    
    func fill(with item: OnBoardingModel) {
        imageView.image = item.image
        bodyLabel.text = item.body
        setupTitle(title: item.title, redTitle: item.redTitle)
    }
    
    private func setupTitle(title: String, redTitle: String) {
        let attributedString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textDarkDefault])
        let redAttributedString = NSAttributedString(string: redTitle, attributes: [NSAttributedString.Key.foregroundColor: Theme.shared.blue])
        attributedString.append(redAttributedString)
        titleLabel.attributedText = attributedString
    }
}
