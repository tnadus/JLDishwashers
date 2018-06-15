//
//  GridViewModel.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import UIKit

/**
 *
 * This ProductsGridViewModel class is making data ready for presentation
 */
class ProductsGridViewModel {
    
    //MARK: Properties
    let productsAPI: JLProductsAPI
    var products: Dynamic<[Product]> = Dynamic(value:[])
    var title = "Loading..."
    let cache = NSCache<AnyObject, AnyObject>()

    
    /// Initialize ProductsGridViewModel instance
    ///
    /// - Parameter productsAPI: Abstract Product Data provider
    init(productsAPI: JLProductsAPI) {
        self.productsAPI = productsAPI
        
        productsAPI.fetchProductList(onSuccess: { (products) in
            self.title = "Dishwashers (\(products.count))"
            self.products.value = products
        }) { (err) in
            self.title = "Data can not be loaded"
            self.products.value = []
            print("Failed to fetch data ", err.localizedDescription)
        }
    }
    
    /// Calculate the required size for cell
    ///
    /// - Parameters:
    ///   - width: cell width
    ///   - height: cell height
    /// - Returns: CGSize instance using width & height
    func cellSize(width: CGFloat, height: CGFloat) -> CGSize {
        let size = CGSize(width: width, height: height)
        return size
    }
    
    /// Create title for cell
    ///
    /// - Parameter indexPath: cell indexPath
    /// - Returns: NSAttributedString intance including product title & price
    func cellTitle(indexPath: IndexPath) -> NSAttributedString {
        if products.value.count > 0 {
            let attrsRegular = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray]
            let attrsBold = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.black]
            let description = NSAttributedString(string: products.value[indexPath.row].title + "\n", attributes: attrsRegular)
            let price = NSAttributedString(string: products.value[indexPath.row].price.now + products.value[indexPath.row].price.currency, attributes: attrsBold)
            let textAll = NSMutableAttributedString()
            textAll.append(description)
            textAll.append(price)
            return textAll
        }
        return NSAttributedString(string: "")
    }
    
    
    /// Load product images asyncronously
    ///
    /// - Parameters:
    ///   - urlString: url address of image
    ///   - completion: Returns a valid image If request is successful
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        if let img = cache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(img)
            return
        }
        
        ImageLoader.load(urlString: urlString) { data in
            
            if let dataImg = data {
                if let img = UIImage(data: dataImg) {
                    self.cache.setObject(img, forKey: urlString as AnyObject)
                    completion(img)
                    return
                }
            }
            completion(nil)
        }
    }
}
