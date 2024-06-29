//
//  MainViewController + Extension.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit

protocol CollectionSectionLayoutProvider: AnyObject {
    func createSection(layoutSection: LayoutSection) -> NSCollectionLayoutSection
}

extension CollectionSectionLayoutProvider {
    func createSection(layoutSection: LayoutSection) -> NSCollectionLayoutSection {
        let itemData = layoutSection.item
        let groupData = layoutSection.group
        let sectionSetting = layoutSection.settings
        let item = NSCollectionLayoutItem(layoutSize: itemData.itemSize)
        item.contentInsets = itemData.contentInsets
        item.edgeSpacing = itemData.edgeSpacing
        
        let group: NSCollectionLayoutGroup
        switch sectionSetting.direction {
        case .vertical:
            group = NSCollectionLayoutGroup.vertical(layoutSize: groupData.groupSize, subitems: [.init(layoutSize: groupData.groupSize)])
        case .horizontal:
            group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupData.groupSize,
            subitems: [.init(layoutSize: groupData.groupSize)])
        }
        
        group.edgeSpacing = groupData.edgeSpacing
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionSetting.contentInsets
        section.interGroupSpacing = groupData.interGroupSpacing
        if let scrollBehavior = sectionSetting.scrollBehavior {
            section.orthogonalScrollingBehavior = scrollBehavior
        }
        
        let supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = sectionSetting.supplementaryViews.map { supplementaryView in
            return NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: supplementaryView.viewSize,
                elementKind: supplementaryView.elementKind.identifier,
                alignment: supplementaryView.alignment)
        }
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
}

struct SectionItem {
    var itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
    var interItemSpacing: CGFloat = 0
    var edgeSpacing: NSCollectionLayoutEdgeSpacing? = nil
    var contentInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
}

struct SectionGroup {
    var groupSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
    var contentInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    var edgeSpacing: NSCollectionLayoutEdgeSpacing? = nil
    var interGroupSpacing: CGFloat = 0
}

struct SectionSettings {
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior? = nil
    var contentInsets: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
    var interGroupSpacing: CGFloat = 0
    var supplementaryViews: [SupplementaryView] = []
    var direction: SectionDirection = .vertical
}

enum SectionDirection {
    case vertical
    case horizontal
}

struct SupplementaryView {
    var contentInsets: NSDirectionalEdgeInsets = .zero
    var viewSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(20))
    var elementKind: UICollectionReusableView.Type
    var alignment: NSRectAlignment = .top
}

struct LayoutSection {
    var item: SectionItem = .init()
    var group: SectionGroup = .init()
    var settings: SectionSettings = .init()
}

enum MonitoringDetails: Int, CaseIterable {
    case survey
    case advices
    case articles
}
