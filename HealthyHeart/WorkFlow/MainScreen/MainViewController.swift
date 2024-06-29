//
//
//  MainViewController.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//
//

import UIKit
import SnapKit

protocol MainScreen: AnyObject {
    var presenter: IMainPresenter! { get set }
}

typealias IMainViewController = BaseViewController & MainScreen

class MainViewController: IMainViewController {
    
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "personIcon"), for: .normal)
        button.addTarget(self, action: #selector(pushToProfile), for: .touchUpInside)
        return button
    }()
    
    private let profileButtonBackground = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let notificationsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "bell"), for: .normal)
        button.addTarget(self, action: #selector(pushToNotifications), for: .touchUpInside)
        return button
    }()
    
    private let notificationButtonBackground = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        return stack
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var presenter: IMainPresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
        setupCollectionView()
        registerCollectionViewCells()
        registerHeaders()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.add {
            stackView
            collectionView
            profileButtonBackground
            notificationButtonBackground
        }
        profileButtonBackground.addSubview(profileButton)
        notificationButtonBackground.addSubview(notificationsButton)
        
        stackView.addArrangedSubview(profileButtonBackground)
        stackView.addArrangedSubview(notificationButtonBackground)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        profileButtonBackground.snp.makeConstraints { make in
            make.height.equalTo(heightComputed(44))
            make.width.equalTo(widthComputed(44))
        }
        
        notificationButtonBackground.snp.makeConstraints { make in
            make.height.equalTo(heightComputed(44))
            make.width.equalTo(widthComputed(44))
        }
        
        profileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(heightComputed(28))
            make.width.equalTo(widthComputed(28))
        }
        
        notificationsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(heightComputed(28))
            make.width.equalTo(widthComputed(28))
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(heightComputed(24))
            make.leading.equalToSuperview().offset(widthComputed(16))
            make.trailing.equalToSuperview().offset(widthComputed(-16))
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(heightComputed(24))
            make.horizontalEdges.equalToSuperview().inset(widthComputed(16))
            make.bottom.equalToSuperview()
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        view.backgroundColor = .bgPrimary
        profileButtonBackground.backgroundColor = themeProperties.bgGrayButtons
        notificationButtonBackground.backgroundColor = themeProperties.bgGrayButtons
    }
    
    @objc private func pushToProfile(_ sender: UIButton) {
        presenter.pushToProfile()
    }
    
    @objc private func pushToNotifications(_ sender: UIButton) {
        presenter.pushToNotifications()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = getCompositionLayout()
    }
    
    func registerCollectionViewCells() {
        collectionView.registerCells(cells: [
            SurveyCollectionViewCell.self,
            AdvicesCollectionViewCell.self,
            ArticlesCollectionViewCell.self
        ])
    }
    
    func registerHeaders() {
        collectionView.registerItemsSupplementaryView(view: SectionHeaderTitleView.self)
        collectionView.registerItemsSupplementaryView(view: SectionSmallHeaderView.self)
    }
}

extension MainViewController: IMainDelegate {
    
}
