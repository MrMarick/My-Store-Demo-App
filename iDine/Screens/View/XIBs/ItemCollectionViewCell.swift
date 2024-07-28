//
//  ItemCollectionViewCell.swift
//  iDine
//
//  Created by Karma Strategies on 26/07/24.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImg: DynamicImgImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemUnitPrize: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
            cardView.layer.shadowOpacity = 0.5
            cardView.layer.shadowRadius = 5
            cardView.layer.masksToBounds = false
            cardView.layer.cornerRadius = 10
        }
    }
    
    var itemData: ItemData?
    var itemExists = false
    var isFavorite = false
    weak var delegate: CollectionCellDelegate?
    weak var favDelegate: FavoriteDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        favBtn.tintColor = .black
    }
    
    @IBAction func favBtnActn(_ sender: Any) {
        favDelegate?.favItemAdded()
        if isFavorite {
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favBtn.tintColor = .black
            if let index = AppPreferences.shared.favItem.firstIndex(where: { $0.id == itemData?.id }) {
                AppPreferences.shared.favItem.remove(at: index)
            }
        } else {
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favBtn.tintColor = .red
            guard let itemData = itemData else { return }
                AppPreferences.shared.favItem.append(itemData)
            
        }
            // Toggle the flag
            isFavorite.toggle()
    }
    
    
    @IBAction func addItemBtnActn(_ sender: Any) {
        guard let itemData = itemData else { return }
        delegate?.showToastMessage("\(itemData.name) is added to your cart")
        for (index, element) in AppPreferences.shared.oderedItem.enumerated(){
            if element.oderedItemId == itemData.id{
                itemExists = true
                AppPreferences.shared.oderedItem[index].oderedItemQuantity += 1
                break
            } 
            else {
                itemExists = false
            }
        }
        if !itemExists {
            AppPreferences.shared.oderedItem.append(OrderItemList(oderedItemId: itemData.id, oderedItemName: itemData.name, oderedItemPrice: itemData.price, oderedItemQuantity: 1, oderedItemImg: itemData.icon))
        }
    }
}

protocol CollectionCellDelegate: AnyObject {
    func showToastMessage(_ message: String)
}
protocol FavoriteDelegate: AnyObject {
    func favItemAdded()
}

