//
//  MainViewController+CreateSection.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit

extension MainViewController: CollectionSectionLayoutProvider {
    
    private struct CellSize: IFigmaConvertible {
        static let photoHeight = heightComputed(210)
        static let photoWidth = heightComputed(210)
    }
    
    func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            guard let section = MonitoringDetails(rawValue: section) else {
                fatalError()
            }
            switch section {
            case .survey:
                return self?.createSection(layoutSection: .init(item: .init(itemSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))), group: .init(groupSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(90))), settings: .init(contentInsets: .init(top: 10, leading: 0, bottom: 24, trailing: 0), supplementaryViews: [.init(elementKind: SectionHeaderTitleView.self, alignment: .top)])))
            case .advices:
                return self?.createSection(layoutSection: .init(group: .init(groupSize: .init(widthDimension: .absolute(CellSize.photoWidth), heightDimension: .absolute(CellSize.photoHeight)), interGroupSpacing: 17), settings: .init(scrollBehavior: .continuous, contentInsets: .init(top: 10, leading: 0, bottom: 24, trailing: 0), supplementaryViews: [.init(elementKind: SectionSmallHeaderView.self, alignment: .top)])))
            case .articles:
                return self?.createSection(layoutSection: .init(group: .init(groupSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(288)), interGroupSpacing: 17), settings: .init( contentInsets: .init(top: 10, leading: 0, bottom: 10, trailing: 0), supplementaryViews: [.init(elementKind: SectionSmallHeaderView.self, alignment: .top)])))
            }
        }
    }
}
