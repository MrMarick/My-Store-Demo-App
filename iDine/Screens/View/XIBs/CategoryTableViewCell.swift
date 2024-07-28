//
//  CategoryTableViewCell.swift
//  iDine
//
//  Created by Karma Strategies on 26/07/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryList: [ItemData] = []{
        didSet{
            categoryCollectionView.reloadData()
        }
    }
    weak var delegate: TableCellDelegate?
    weak var favDelegate: FavoriteTableCellDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        if let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.scrollDirection = .horizontal
                }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func expandCellBtnActn(_ sender: Any) {
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.itemData = categoryList[indexPath.row]
        cell.itemImg.loadImage(urlString: categoryList[indexPath.row].icon, placeholderImage: "")
        cell.itemName.text = categoryList[indexPath.row].name
        cell.itemUnitPrize.text = String(categoryList[indexPath.row].price)
        cell.delegate = self
        cell.favDelegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 30)/2
        return CGSize(width: width, height: (collectionView.frame.size.height - 10))
    }
    
}

extension CategoryTableViewCell: CollectionCellDelegate {
    func showToastMessage(_ message: String) {
        delegate?.showToastMessage(message)
    }
}

extension CategoryTableViewCell: FavoriteDelegate {
    func favItemAdded() {
        favDelegate?.favItemAdded()
    }
    
    
}


protocol TableCellDelegate: AnyObject {
    func showToastMessage(_ message: String)
}
protocol FavoriteTableCellDelegate: AnyObject {
    func favItemAdded()
}
