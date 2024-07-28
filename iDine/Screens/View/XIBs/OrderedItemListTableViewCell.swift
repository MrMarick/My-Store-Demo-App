//
//  OrderedItemListTableViewCell.swift
//  iDine
//
//  Created by Karma Strategies on 21/03/24.
//

import UIKit

class OrderedItemListTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImg: DynamicImgImageView!{
        didSet{
            itemImg.layer.cornerRadius = itemImg.frame.width/2
        }
    }
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var noOfItems: UILabel!
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
            cardView.layer.shadowOpacity = 0.5
            cardView.layer.shadowRadius = 5
            cardView.layer.masksToBounds = false
            cardView.layer.cornerRadius = 10
        }
    }
    var totalPriceDidChange: ((Int) -> Void)?
    var reloadTableView: (() -> Void)?
    var noOfItem = 1{
        didSet{
            self.noOfItems.text = String(noOfItem)
            self.totalPrice.text = "₹\(subTotalPrice * Double(noOfItem))"
            totalPriceDidChange?(noOfItem)
        }
    }
    var subTotalPrice:Double = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(name: String, img: String, price: Double, quantity: Int){
        self.itemName.text = name
        self.itemImg.loadImage(urlString: img, placeholderImage: "")
        self.subTotalPrice = price
        self.noOfItem = quantity
        self.unitPrice.text = String(price)
    }
    @IBAction func decreaseItem(_ sender: Any) {
        if noOfItem > 0{
            noOfItem -= 1
        }
        reloadTableView?()
    }
    @IBAction func increaseItem(_ sender: Any) {
        noOfItem += 1
    }
    
}
