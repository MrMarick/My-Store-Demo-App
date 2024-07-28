//
//  UIColor+Extension.swift
//  FancyApp
//
//  Created by Karma Strategies on 24/01/24.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbColorValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbColorValue)
        
        let r = (rgbColorValue & 0xff0000) >> 16
        let g = (rgbColorValue & 0xff00) >> 8
        let b = rgbColorValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
