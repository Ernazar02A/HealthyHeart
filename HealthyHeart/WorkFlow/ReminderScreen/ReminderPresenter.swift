//
//  
//  ReminderPresenter.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IReminderDelegate: AnyObject {
    
}

protocol IReminderPresenter {
    func setDelegate(_ delegate: IReminderDelegate)
}

class ReminderPresenter: IReminderPresenter {
    
    let navigator: IReminderNavigator
    
    weak var delegate: IReminderDelegate?
    
    init(navigator: IReminderNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: IReminderDelegate) {
        self.delegate = delegate
    }
}
