//
//  
//  AnalyticsPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IAnalyticsDelegate: AnyObject {
    
}

protocol IAnalyticsPresenter {
    func setDelegate(_ delegate: IAnalyticsDelegate)
}

class AnalyticsPresenter: IAnalyticsPresenter {
    
    let navigator: IAnalyticsNavigator
    
    weak var delegate: IAnalyticsDelegate?
    
    init(navigator: IAnalyticsNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: IAnalyticsDelegate) {
        self.delegate = delegate
    }
}
