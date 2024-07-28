//
//  CartVC.swift
//  iDine
//
//  Created by Karma Strategies on 21/03/24.
//

import UIKit

class CartVC: UIViewController {
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var grossTotal: UILabel!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var orderPlaceBtn: UIButton!
    @IBOutlet weak var CartTableView: UITableView!
    var count = 0
    var cartItem: ItemData?
    var orderItemList: [OrderItemList] = []{
        didSet{
            CartTableView.reloadData()
        }
    }
    var totalPrice: Double = 0{
        didSet{
            subTotal.text = "₹\(totalPrice)"
            gross = totalPrice
        }
    }
    var gross: Double = 0{
        didSet{
            grossTotal.text = "₹\(gross)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        orderItemList = AppPreferences.shared.oderedItem
        if AppPreferences.shared.oderedItem.isEmpty{
            priceStackView.isHidden = true
            orderPlaceBtn.isHidden = true
            self.showAlert(withTitle: "", withMessage: "Your cart is empty") {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else {
            priceStackView.isHidden = false
            orderPlaceBtn.isHidden = false
        }
        
    }
    @IBAction func placeOrder(_ sender: Any) {
        if AppPreferences.shared.oderedItem.isEmpty{
            self.showToastInMiddle(message: "Your cart is empty")
        }else{
            AppPreferences.shared.oderedItem = []
            self.showAlert(withTitle: "Order Placed", withMessage: "We are preparing your order") {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}
extension CartVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppPreferences.shared.oderedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderedItemListTableViewCell", for: indexPath) as! OrderedItemListTableViewCell
        cell.totalPriceDidChange = { noOfItem in
            AppPreferences.shared.oderedItem[indexPath.row].oderedItemQuantity = noOfItem
            self.totalPrice = 0
            for item in AppPreferences.shared.oderedItem{
                let price  = item.oderedItemPrice * Double(item.oderedItemQuantity)
                self.totalPrice = self.totalPrice + price
            }
        }
        cell.reloadTableView = {
            tableView.reloadData()
        }
        cell.configCell(name: AppPreferences.shared.oderedItem[indexPath.row].oderedItemName, img: AppPreferences.shared.oderedItem[indexPath.row].oderedItemImg, price: AppPreferences.shared.oderedItem[indexPath.row].oderedItemPrice, quantity: AppPreferences.shared.oderedItem[indexPath.row].oderedItemQuantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
