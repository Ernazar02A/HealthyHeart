//
//  
//  HomeNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IHomeNavigator {
    
}

struct HomeNavigator: IHomeNavigator {
    
    weak var viewController: IHomeViewController!
}

