//
//  UITextField+Extension.swift
//  FancyApp
//
//  Created by Karma Strategies on 21/01/24.
//

import Foundation
import UIKit
private var __maxLengths = [UITextField: Int]()

extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
               return 150 // (default int limit)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(setMaxLength), for: .editingChanged)
        }
    }

    @objc func setMaxLength(textField: UITextField) {
        let t = textField.text
        textField.text = t?.prefix(maxLength).description
    }
}
