//
//  AdvicesCollectionViewCell.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit
import SnapKit
import Kingfisher

class AdvicesCollectionViewCell: BaseCollectionViewCell {
    
    private let photo: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    override func setup() {
        super.setup()
        viewStyle()
        roundTopCorners(of: photo, radius: 20)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        add {
            photo
            dateLabel
            descriptionLabel
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        photo.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(heightComputed(50))
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom).offset(heightComputed(12))
            make.leading.equalToSuperview().offset(widthComputed(12))
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(heightComputed(21))
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(heightComputed(8))
            make.leading.equalToSuperview().offset(widthComputed(12))
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(heightComputed(36))
            make.bottom.equalToSuperview().offset(heightComputed(-12))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        dateLabel.textColor = themeProperties.labelSecondary
        descriptionLabel.textColor = themeProperties.labelPrimary
        backgroundColor = themeProperties.bgGraySecondary
    }
    
    private func viewStyle() {
        layer.cornerRadius = 10
    }
    
    private func roundTopCorners(of view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func fill(with item: AdviceModel?) {
        //        if let item, let url = URL(string: item.photo ?? "icon") {
        //            photo.kf.setImage(with: url)
        //        }
        photo.image = UIImage(named: item?.photo ?? "medCard")
        dateLabel.text = item?.date
        descriptionLabel.text = item?.description
    }
}


struct AdviceModel {
    var photo: String?
    var date: String?
    var description: String?
}
