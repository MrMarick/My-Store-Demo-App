//
//  UIDate+Extension.swift
//  FancyApp
//
//  Created by Karma Strategies on 16/01/24.
//

import Foundation

extension Date {
 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: Date())

    }
}
