//
//  UIViewController+Extenstion.swift
//  vomos
//
//  Created by Guestmac on 12/23/21.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func showAlert(withTitle title: String, withMessage message:String, btnAction : (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                btnAction?()
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showToast(message : String, duration: Int = 4, completionHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height
            
            let toastLabelHeight = round(CGFloat(message.count) / 25.0) * 44
            let toastLabel = UILabel(frame: CGRect(x: 32, y: height - toastLabelHeight - 60, width: width - 64, height: toastLabelHeight))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.numberOfLines = 0
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
            UIView.animate(withDuration: 4.0, delay: 0.3, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
                if let completionHandler = completionHandler {
                    completionHandler()
                }
            })
        }
    }
    
    func showToastInMiddle(message: String, duration: TimeInterval = 4, completionHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let toastLabel = UILabel()
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center
            toastLabel.numberOfLines = 0
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10
            toastLabel.clipsToBounds = true
            
            // Adjust the frame of the toast label to center it on the screen
            let toastWidth: CGFloat = self.view.frame.size.width - 60
            let toastHeight: CGFloat = 50
            let screenWidth = UIScreen.main.bounds.width
            let screenHeight = self.view.frame.height
            toastLabel.frame = CGRect(x: (screenWidth - toastWidth) / 2, y: (screenHeight - toastHeight) / 4, width: toastWidth, height: toastHeight)
            
            self.view.addSubview(toastLabel)
            
            UIView.animate(withDuration: duration, delay: 0.3, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
                completionHandler?()
            })
        }
    }
    
    func displayAPIError(errorstrng: String) {
        if(errorstrng.contains("Invalid")) {
            self.showToast(message: "Invalid Response!")
        } else {
            print(errorstrng)
        }
    }
}

