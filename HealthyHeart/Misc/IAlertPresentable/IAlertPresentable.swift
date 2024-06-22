//
//  IAlertPresentable.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

protocol IAlertPresentable {
    var viewControllerToPresentAlert: UIViewController { get }
}

enum CloseTypeScreen {
    case closeRoot
    case pop
}

extension IAlertPresentable {
    func showNativeSingleButtonAlert(
        title: String? = nil,
        message: String? = nil,
        buttonText: String? = nil,
        buttonStyle: UIAlertAction.Style = .default,
        secondaryText: String? = nil,
        secondaryButtonStyle: UIAlertAction.Style = .default,
        tap: (() -> ())? = nil,
        secondaryTap: (() -> ())? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: buttonText ?? "Закрыть",
                style: buttonStyle,
                handler: { _ in
                    tap?()
                }
            )
        )
        if let secondaryText {
            alert.addAction(
                UIAlertAction(
                    title: secondaryText,
                    style: secondaryButtonStyle,
                    handler: { _ in
                        if let secondaryTap {
                            secondaryTap()
                        } else {
                            alert.dismiss(animated: true)
                        }
                    }
                )
            )
        }
        viewControllerToPresentAlert.present(alert, animated: true)
    }
    
    func showMessage(message: String, duration: TimeInterval, exiteType: CloseTypeScreen?, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        viewControllerToPresentAlert.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alertController.dismiss(animated: true, completion: {
                switch exiteType {
                case .closeRoot:
                    self.viewControllerToPresentAlert.navigationController?.popToRootViewController(animated: true)
                case .pop:
                    self.viewControllerToPresentAlert.navigationController?.popViewController(animated: true)
                case .none:
                    break
                }
                handler?()
            })
        }
    }
}

