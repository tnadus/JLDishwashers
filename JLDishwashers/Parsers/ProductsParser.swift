//
//  ProductsParser.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 * This ProductsParser class parses data and returns in products array
 */
class ProductsParser {
    
    //MARK: JSON Keys to avoid any typo error when accesing json elements
    private enum JSONKey: String {
        case products
    }
    
    private enum ProductKeys: String {
        case productId
        case title
        case price
        case image
    }
    
    private enum PriceKeys: String {
        case was
        case now
        case currency
    }
    
    /// Price builder method to create Price instance
    ///
    /// - Parameter priceJSON: requires price json data in SwiftyJSON.JSON type
    /// - Returns: Price instance If Successful, otherwise nil
    private static func makePrice(_ priceJSON: SwiftyJSON.JSON) -> Price? {
        guard let was  = priceJSON[PriceKeys.was.rawValue].string,
            let now = priceJSON[PriceKeys.now.rawValue].string,
            let currency = priceJSON[PriceKeys.currency.rawValue].string
            else {
                return nil
        }
        
        return Price(was: was, now: now, currency: currency)
    }
        
    /// Product builder method to create Product instance
    ///
    /// - Parameter productJSON: requires product json data in SwiftyJSON.JSON type
    /// - Returns: Product instance If Successful, otherwise nil
    private static func makeProduct(_ productJSON: SwiftyJSON.JSON) -> Product? {
    
        guard let productId = productJSON[ProductKeys.productId.rawValue].string,
            let title = productJSON[ProductKeys.title.rawValue].string,
        let image = productJSON[ProductKeys.image.rawValue].string,
            let price = ProductsParser.makePrice(productJSON[ProductKeys.price.rawValue])
        else {
            return nil
        }
        return Product(productId: productId, price: price, title: title, imageURLPath: ("https:" + image))
    }
}

//MARK: Public methods

extension ProductsParser {
    
    /// Parse Data and return products array
    ///
    /// - Parameter data: should be in json format
    /// - Returns: Array of Product
    static func parse(data: Data) -> [Product]? {
        
        let jsonData = JSON(data: data)
        guard let productsJSON = jsonData[JSONKey.products.rawValue].array else { return nil }
        
        var products = [Product]()
        for productJSON in productsJSON {
            guard let product = ProductsParser.makeProduct(productJSON) else {
                return nil
            }
            products.append(product)
        }
        return products.count > 0 ? products : nil
    }
}
