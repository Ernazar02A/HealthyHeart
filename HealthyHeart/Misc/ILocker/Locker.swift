//
//  Locker.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import Foundation

protocol ILocker {
    func lock()
    func unlock()
    func forceUnlock()
}

final class Locker {
    private var locker: ILocker = DefaultScreenLocker()
    private var didUnlock = false

    func performTask(
        if condition: @escaping () -> Bool = { true },
        task: @escaping () -> Void,
        completion: @escaping () -> Void
    ) {
        guard condition() else {
            task()
            return
        }
        lock()
        DispatchQueue.global().async {
            task()
            DispatchQueue.main.async {
                self.unlock()
                completion()
            }
        }
    }

    func lock() {
        didUnlock = false
        locker.lock()
    }

    func unlock() {
        if !didUnlock {
            locker.unlock()
        }
        didUnlock = true
    }
    
    func forceUnlock() {
       didUnlock = true
       locker.unlock()
   }
}
