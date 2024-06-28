//
//  
//  DoctorsPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IDoctorsDelegate: AnyObject {
    
}

protocol IDoctorsPresenter {
    func setDelegate(_ delegate: IDoctorsDelegate)
}

class DoctorsPresenter: IDoctorsPresenter {
    
    let navigator: IDoctorsNavigator
    
    weak var delegate: IDoctorsDelegate?
    
    init(navigator: IDoctorsNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: IDoctorsDelegate) {
        self.delegate = delegate
    }
}
