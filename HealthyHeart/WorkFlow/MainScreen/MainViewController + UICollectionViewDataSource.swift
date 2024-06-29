//
//  MainViewController + UICollectionViewDataSource.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { MonitoringDetails.allCases.count }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = MonitoringDetails(rawValue: section) else { return 0 }
        return presenter.getCountItem(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = MonitoringDetails(rawValue: indexPath.section) else {
            fatalError("ObjectDetailingSectionType")
        }
        switch section {
        case .survey:
            let cell = collectionView.getReuseCell(
                for: indexPath,
                with: SurveyCollectionViewCell.self
            )
            return cell
        case .advices:
            let cell = collectionView.getReuseCell(
                for: indexPath,
                with: AdvicesCollectionViewCell.self
            )
            let advices = presenter.advice
            cell.fill(with: advices[indexPath.item])
            return cell
        case .articles:
            let cell = collectionView.getReuseCell(
                for: indexPath,
                with: ArticlesCollectionViewCell.self
            )
            let articles = presenter.advice
            cell.fill(with: articles[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if presenter.feedback.count - 1 == indexPath.row && !presenter.isLoading {
//            presenter.loadMoreItems()
//        }
    }
}
