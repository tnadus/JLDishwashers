//
//  GridViewModel.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import UIKit

class ProductsGridViewModel {
    
    let productsAPI: JLProductsAPI
    var title = "Loading..."
    let cache = NSCache<AnyObject, AnyObject>()
    let dateFormatterInput = DateFormatter()
    let dateFormatterOutput = DateFormatter()
    
    var products: Dynamic<[Product]> = Dynamic(value:[])
    
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
    
    func cellSize(width: CGFloat, height: CGFloat) -> CGSize {
        let size = CGSize(width: width, height: height)
        return size
    }
    
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
    
    func formattedDateString(_ dateString: String) -> String {
        let dateObj = dateFormatterInput.date(from: dateString)
        if let date = dateObj {
            let formattedString = dateFormatterOutput.string(from:date)
            return formattedString
        }
        return ""
    }
    
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
