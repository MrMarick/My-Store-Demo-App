//
//  ItemCategoryTableViewCell.swift
//  iDine
//
//  Created by Karma Strategies on 28/07/24.
//

import UIKit

class ItemCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
