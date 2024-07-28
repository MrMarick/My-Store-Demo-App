//
//  CategoryVC.swift
//  iDine
//
//  Created by Karma Strategies on 28/07/24.
//

import UIKit

class CategoryVC: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categoryList: [CategoriesData] = []
    var selectedCategoryList: [CategoriesData] = []
    var HomeVC = CuisinesVC()
    var delegate: CategoryVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.didUpdateCategoryList(newList: self.categoryList)
        }
    }
   
}
extension CategoryVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCategoryTableViewCell", for: indexPath) as! ItemCategoryTableViewCell
        cell.categoryItem.text = categoryList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.dismiss(animated: true) {
            self.selectedCategoryList = []
            self.selectedCategoryList.append(self.categoryList[indexPath.row])
            self.delegate?.didUpdateCategoryList(newList: self.selectedCategoryList)

        }
    }
    
}
protocol CategoryVCDelegate: AnyObject {
    func didUpdateCategoryList(newList: [CategoriesData])
}



