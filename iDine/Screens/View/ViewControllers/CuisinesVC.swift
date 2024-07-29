//
//  CuisinesVC.swift
//  iDine
//
//  Created by Karma Strategies on 19/03/24.
//

import UIKit

class CuisinesVC: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var favoriteBadge: UILabel!
    @IBOutlet weak var cartBadge: UILabel!
    @IBOutlet weak var cartBadgeView: UIView!
    @IBOutlet weak var favBadgeView: UIView!
    @IBOutlet weak var HeaderView: DashedBorderedView!
    var categoryList: [CategoriesData] = []
    var categoryItemsList: [CategoriesData] = []{
        didSet{
            categoryList = categoryItemsList
        }
    }
    var selectedTital = ""
    var selectedDishId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryItemsList = ViewModel.shared.fetchJsonData(jsonName: "Product")
        
        if AppPreferences.shared.favItem.count == 0 {
            favBadgeView.isHidden = true
        }else {
            favBadgeView.isHidden = false
        }
        if AppPreferences.shared.oderedItem.count == 0{
            cartBadgeView.isHidden = true
        }else {
            cartBadgeView.isHidden = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.label
//        HeaderView.backgroundColor = .systemYellow
//        setGradientBackground(view: HeaderView)
    }
    override func viewDidLayoutSubviews() {
        DispatchQueue.main.async {
            self.setGradientColor(view: self.HeaderView, colors: [UIColor(hex: "EF8B59"), UIColor(hex: "F2D355")])
        }
    }
    
    func setGradientColor(view: UIView, colors: [UIColor]) {
        // Remove any existing gradient layers
        if let sublayers = view.layer.sublayers {
            for layer in sublayers where layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Ensure the gradient layer resizes with the view
        view.layer.layoutSublayers()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoCategory"){
            let vc = segue.destination as? CategoryVC
            vc?.categoryList = self.categoryItemsList
            vc?.delegate = self
        }
    }
    
    
    @IBAction func categoryBtnActn(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoCategory", sender: self)
    }
}

extension CuisinesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryName.text = categoryList[indexPath.row].name
        cell.categoryList = categoryList[indexPath.row].items
        cell.delegate = self
        cell.favDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
}
extension CuisinesVC: CategoryVCDelegate {
    func didUpdateCategoryList(newList: [CategoriesData]) {
        self.categoryList = newList
        self.categoryTableView.reloadData()
        print(categoryList)
    }
}

extension CuisinesVC: FavoriteTableCellDelegate{
    func favItemAdded() {
        favoriteBadge.text = "!"
        if AppPreferences.shared.favItem.count == 0 {
            favBadgeView.isHidden = true
        }else {
            favBadgeView.isHidden = false
        }
    }
    
    
}

extension CuisinesVC: TableCellDelegate {
    func showToastMessage(_ message: String) {
        self.showToast(message: message)
        cartBadge.text = "!"
        
        if AppPreferences.shared.oderedItem.count == 0{
            cartBadgeView.isHidden = true
        }else {
            cartBadgeView.isHidden = false
        }
    }
    
    
}




