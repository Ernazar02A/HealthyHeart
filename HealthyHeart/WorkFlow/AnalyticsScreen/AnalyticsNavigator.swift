//
//  
//  AnalyticsNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IAnalyticsNavigator {
    
}

struct AnalyticsNavigator: IAnalyticsNavigator {
    
    weak var viewController: IAnalyticsViewController!
}

