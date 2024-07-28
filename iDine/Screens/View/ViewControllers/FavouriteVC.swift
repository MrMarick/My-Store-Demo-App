//
//  FavouriteVC.swift
//  iDine
//
//  Created by Guestmac on 7/28/24.
//

import Foundation
import UIKit

class FavouriteVC: UIViewController {
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var backImageVw: UIImageView!
    
    var favoritesList: [ItemData] = []{
        didSet{
            favoritesTableView.reloadData()
        }
    }
//        FavoriteItemData(id: 1, item_image: "https://cdn-icons-png.flaticon.com/128/2553/2553691.png", item_name: "Potato Chips", item_qty: 1, item_price: 40.00),
//        FavoriteItemData(id: 2, item_image: "https://cdn-icons-png.flaticon.com/128/2405/2405479.png", item_name: "Keventers Thick Shake 60 ml", item_qty: 1, item_price: 80.00)
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesList = AppPreferences.shared.favItem
    }
    
    
}

extension FavouriteVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesCell
        cell.configure(favoriteItemData: favoritesList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension FavouriteVC: FavoriteCellDelegate {
    func favoriteItemChanged() {
        favoritesList = AppPreferences.shared.favItem
    }
    
    
}
