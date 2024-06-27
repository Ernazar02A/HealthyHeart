//
//  
//  OnBoardingViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 23/6/24.
//
//

import UIKit
import SnapKit

struct OnBoardingModel {
    let image: UIImage
    let title: String
    let redTitle: String
    let body: String
}

protocol OnBoardingScreen: AnyObject {
    var presenter: IOnBoardingPresenter! { get set }
}

typealias IOnBoardingViewController = BaseViewController & OnBoardingScreen

final class OnBoardingViewController: IOnBoardingViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnboardingCollectionViewCell.self)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var nextButton = MainButton(isActive: true)
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = onboardingData.count
        view.currentPage = 0
        return view
    }()
    private let onboardingData: [OnBoardingModel] = [
        .init(
            image: .onBoarding1,
            title: "Добро пожаловать в ",
            redTitle: "КардиоМед",
            body: "Ваш надежный помощник в заботе о сердечно-сосудистой системе и поддержке здорового образа жизни"
        ),
        .init(
            image: .onBoarding2,
            title: "Мониторинг здоровья в один клик",
            redTitle: "",
            body: "Вводите данные по 8 параметрам и отслеживайте результаты и получайте персонализированные рекомендации"
        ),
        .init(
            image: .onBoarding3,
            title: "Консультации и полезные материалы",
            redTitle: "",
            body: "Записывайтесь на приём к врачу онлайн и изучайте статьи, видео и советы для поддержания здоровья"
        )
    ]
    
    var presenter: IOnBoardingPresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
        updatePageControlButtons()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.add {
            collectionView
            nextButton
            pageControl
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.bottom.equalTo(pageControl.snp.top).offset(heightComputed(-20))
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(heightComputed(-50))
        }
        
        nextButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(heightComputed(-30))
            make.height.equalTo(heightComputed(50))
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        view.backgroundColor = themeProperties.bgPrimary
        collectionView.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = Theme.shared.blue
        pageControl.currentPageIndicatorTintColor = themeProperties.labelPrimary
        pageControl.pageIndicatorTintColor = themeProperties.bgGrayDefault
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        nextButton.setTitle("Далее", for: .normal)
    }
    
    @objc
    private func skip() {
        presenter.presentAuthScreen()
    }
    
    @objc
    private func backPage() {
        changePage(by: -1)
    }
    
    @objc 
    private func nextButtonTapped(_ sender: UIButton) {
        sender.animationTapButton()
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            presenter.presentAuthScreen()
        } else {
            changePage(by: 1)
        }
    }
    
    private func changePage(by offset: Int) {
        let visibleItems = collectionView.indexPathsForVisibleItems
        if let currentIndexPath = visibleItems.first {
            let newIndex = currentIndexPath.item + offset
            guard newIndex >= 0 && newIndex < onboardingData.count else { return }
            let nextIndexPath = IndexPath(item: newIndex, section: currentIndexPath.section)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = nextIndexPath.item
            updatePageControlButtons()
        }
    }
    
    private func updatePageControlButtons() {
        switch pageControl.currentPage {
        case 0:
            navigationItem.leftBarButtonItem = nil
            let rightBarButton = UIBarButtonItem(title: "Пропустить", style: .plain, target: self, action: #selector(skip))
            navigationItem.rightBarButtonItem = rightBarButton
            nextButton.setTitle("Далее", for: .normal)
        case 1:
            let leftBarButton = createBarButtonItemWithIconAndTitle(icon: .arrowLeftIcon, title: "  Назад", action:  #selector(backPage))
            navigationItem.leftBarButtonItem = leftBarButton
            let rightBarButton = UIBarButtonItem(title: "Пропустить", style: .plain, target: self, action: #selector(skip))
            navigationItem.rightBarButtonItem = rightBarButton
            nextButton.setTitle("Далее", for: .normal)
        case 2:
            let leftBarButton = createBarButtonItemWithIconAndTitle(icon: .arrowLeftIcon, title: "  Назад", action: #selector(backPage))
            navigationItem.leftBarButtonItem = leftBarButton
            navigationItem.rightBarButtonItem = nil
            nextButton.setTitle("Войти", for: .normal)
        default:
            break
        }
    }
    
    private func createBarButtonItem(title: String, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: title, style: .plain, target: self, action: action)
    }
    
    private func createBarButtonItemWithIconAndTitle(icon: UIImage?, title: String, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(icon, for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
}

//MARK: - IOnBoardingDelegate
extension OnBoardingViewController: IOnBoardingDelegate { }

//MARK: - UICollectionViewDataSource
extension OnBoardingViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return onboardingData.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.getReuseCell(
            for: indexPath,
            with: OnboardingCollectionViewCell.self
        )
        
        let onboardingItem = onboardingData[indexPath.item]
        cell.fill(with: onboardingItem)
        return cell
    }
}

//MARK: - UICollectionViewDelegate && UICollectionViewDelegateFlowLayout
extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
        updatePageControlButtons()
    }
}
