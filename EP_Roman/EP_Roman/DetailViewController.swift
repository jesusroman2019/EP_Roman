//
//  DetailViewController.swift
//  EP_Roman
//
//  Created by user191022 on 5/27/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var anchorBottomScroll: NSLayoutConstraint!
    
    @IBOutlet private weak var textChange: UILabel!
    
    
    @IBAction private func tapToCloseKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    @IBAction private func btnVerMas(sender: UIButton) {
        
        //self.textChange.numberOfLines = 10
        
        switch self.textChange.numberOfLines {
        case 2:
            self.textChange.numberOfLines = 10
        case 10:
            self.textChange.numberOfLines = 2
        default:
            self.textChange.numberOfLines = 2
        }
            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotification()
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        [.portrait, .landscapeRight]
    }
}


//MARK: - Keyboard events
extension DetailViewController {
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        
        UIView.animate(withDuration: animationDuration) {
            self.anchorBottomScroll.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.anchorBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
