//
//  MainViewController + UICollectionViewDelegate.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//

import UIKit

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionType = MonitoringDetails(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        if kind == SectionHeaderTitleView.identifier {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderTitleView.identifier, for: indexPath) as! SectionHeaderTitleView
            switch sectionType {
            case .survey:
                headerView.setupTitle(title: "Мониторинг", color: themeProperties.labelPrimary)
            default: return UICollectionReusableView()
            }
            return headerView
        }  else if kind == SectionSmallHeaderView.identifier {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionSmallHeaderView.identifier, for: indexPath) as! SectionSmallHeaderView
            switch sectionType {
            case .advices:
                headerView.setup(title: "Советы")
            case .articles:
                headerView.setup(title: "Статьи")
            default: return UICollectionReusableView()
            }
            return headerView
        } else {
            return UICollectionReusableView()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let sectionType = MonitoringDetails(rawValue: indexPath.section) else {
//            return
//        }
//        switch sectionType {
//        case .advices:
////            presenter.tapImage(index: indexPath.item)
//        case .articles:
//            
//        default:
//            break
//        }
//    }
}
