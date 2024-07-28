//
//  Helper.swift
//  FancyApp
//
//  Created by Karma Strategies on 06/02/24.
//

import Foundation
import UIKit
class Helper{
    static let shared = Helper()
    private init() {}
    func setBtnImg(btn: UIButton, img: String){
        btn.setImage(UIImage(systemName: img), for: .normal)
    }
    
    func removeObservers(viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController)
    }
    
    
}
