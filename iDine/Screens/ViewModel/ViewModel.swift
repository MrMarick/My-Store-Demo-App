//
//  ViewModel.swift
//  iDine
//
//  Created by Karma Strategies on 28/03/24.
//

import Foundation
struct ViewModel {
    private init() {}
    static let shared = ViewModel()
    
    func fetchJsonData(jsonName: String) -> [CategoriesData]{
        if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
//            print("\(path) pathhhh")
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                        print("\(data) dataaaaa")
                        return parseJSON(data: data)?.categories ?? []
                    } catch {
                        print("Error reading JSON file:", error)
                        return []
                    }
                } else {
                    print("JSON file not found.")
                    return []
                }
    }
    
    func parseJSON(data: Data) -> ProductJSONResponse? {
            do {
                let item = try JSONDecoder().decode(ProductJSONResponse.self, from: data)
                return item
            } catch {
                print("Error decoding JSON:", error)
                return nil
            }
        }
}
