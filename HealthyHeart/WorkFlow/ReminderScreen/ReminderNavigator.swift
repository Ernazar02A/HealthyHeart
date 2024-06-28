//
//  
//  ReminderNavigator.swift
//  HealthyHeart
//
//  Created by Ernazar on 29/6/24.
//
//

import Foundation

protocol IReminderNavigator {
    
}

struct ReminderNavigator: IReminderNavigator {
    
    weak var viewController: IReminderViewController!
}

