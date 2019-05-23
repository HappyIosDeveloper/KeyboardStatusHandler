//
//  KeyboardStatusHandler.swift
//  KeyboardStatusHandler
//
//  Created by Alfredo Uzumaki on 5/10/19.
//  Copyright © 2019 Alfredo Uzumaki. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func watchKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stopWatchingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if tabBarController != nil {
            if let userInfo = notification.userInfo {
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
                let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
                if let bottomConstraint = view.constraints.filter({ $0.firstAttribute == .bottom }).first {
                    bottomConstraint.constant = isKeyboardShowing ? -keyboardFrame!.height + tabBarController!.tabBar.frame.height : 0
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                    })
                }
            }
        } else {
            if let userInfo = notification.userInfo {
                let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
                let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
                if let bottomConstraint = view.constraints.filter({ $0.firstAttribute == .bottom }).first {
                    bottomConstraint.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
                    UIView.animate(withDuration: 0.3, animations: { () -> Void in
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if let bottomConstraint = view.constraints.filter({ $0.firstAttribute == .bottom }).first {
            UIView.animate(withDuration: 0.3) {
                bottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
}
