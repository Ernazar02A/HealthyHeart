//
//  
//  HomePresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IHomeDelegate: AnyObject {
    
}

protocol IHomePresenter {
    func setDelegate(_ delegate: IHomeDelegate)
}

class HomePresenter: IHomePresenter {
    
    let navigator: IHomeNavigator
    
    weak var delegate: IHomeDelegate?
    
    init(navigator: IHomeNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: IHomeDelegate) {
        self.delegate = delegate
    }
}
