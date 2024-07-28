//
//  AppPreferences.swift
//  DREAMS
//
//  Created by Guestmac on 12/7/21.
//

import Foundation

class AppPreferences {
    //Instantiate AppPreferences
    static let shared = AppPreferences()
    
    private init() {}
   

    var oderedItem: [OrderItemList] = []
    {
        didSet{
            oderedItem = oderedItem.filter {$0.oderedItemQuantity != 0}
            
        }
    }
    var favItem: [ItemData] = []

}
