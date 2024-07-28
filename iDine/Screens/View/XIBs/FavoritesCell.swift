//
//  FavoritesCell.swift
//  iDine
//
//  Created by Guestmac on 7/28/24.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    @IBOutlet weak var favoritesImgVw: DynamicImgImageView!
    @IBOutlet weak var favoriteItemNameLbl: UILabel!
    @IBOutlet weak var itemQtyLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var contentCardView: UIView! {
        didSet {
            contentCardView.layer.shadowOffset = CGSize(width: 5, height: 5)
            contentCardView.layer.shadowOpacity = 0.5
            contentCardView.layer.shadowRadius = 3
            contentCardView.layer.masksToBounds = false
            contentCardView.layer.cornerRadius = 10
        }
    }
    
    var favoriteItemData: ItemData?
    var isFavorite = false
    weak var delegate: FavoriteCellDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favBtn.tintColor = .red

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favBtnActn(_ sender: Any) {
        if isFavorite {
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favBtn.tintColor = .red
            guard let itemData = favoriteItemData else { return }
                AppPreferences.shared.favItem.append(itemData)
        } else {
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favBtn.tintColor = .black
            if let index = AppPreferences.shared.favItem.firstIndex(where: { $0.id == favoriteItemData?.id }) {
                AppPreferences.shared.favItem.remove(at: index)
                guard let itemData = favoriteItemData else { return }
                delegate?.favoriteItemChanged()

            }
        }
            // Toggle the flag
            isFavorite.toggle()
    }
    
    func configure(favoriteItemData: ItemData) {
        self.favoriteItemData = favoriteItemData
        favoritesImgVw.loadImage(urlString: favoriteItemData.icon, placeholderImage: "")
        favoriteItemNameLbl.text = favoriteItemData.name
        itemPriceLbl.text = "₹\(favoriteItemData.price)"

    }

}

protocol FavoriteCellDelegate: AnyObject {
    func favoriteItemChanged()
}
