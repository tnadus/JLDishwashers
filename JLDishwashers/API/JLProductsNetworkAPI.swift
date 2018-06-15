//
//  JLProductsNetworkAPI.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation
import SwiftyJSON

enum JLProductsNetworkAPIError: Error {
    case productURLInvalid(description: String)
    case responseCodeInvalid(description: String)
    case responseDataInvalid(description: String)
}

class JLProductsNetworkAPI: JLProductsAPI {
    
    let API_BASE_URL       = "https://api.johnlewis.com/v1/products/search"
    let API_KEY            = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
    let API_PRODUCT_QUERY  = "dishwasher"
    let API_PAGE_SIZE      = "20"
    
    func fetchProductList(onSuccess: FetchProductsCallback?,
                          onError: FetchProductsErrorCallback?) {
        
        guard let url = urlPathBuilder() else {
            onError?(JLProductsNetworkAPIError.productURLInvalid(description: "URL can not be built correctly"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                self.errorHandler(err, onError)
                return
            }
            
            if response == nil || (response as! HTTPURLResponse).statusCode != 200 {
                self.errorHandler(JLProductsNetworkAPIError.responseCodeInvalid(description: "Response is empty or status code is other than 200"), onError)
                return
            }
            
            guard let data = data, let products:[Product] = ProductsParser.parse(data: data) else {
                self.errorHandler(JLProductsNetworkAPIError.responseDataInvalid(description: "Response data is invalid"), onError)
                return
            }
        
            DispatchQueue.main.sync {
                onSuccess?(products)
            }
            
            }.resume()
    }
}

//MARK - Helper functions

extension JLProductsNetworkAPI {
    
    func errorHandler(_ error: Error, _ handler: FetchProductsErrorCallback?) {
        DispatchQueue.main.sync {
            handler?(error)
        }
    }
    
    func urlPathBuilder() -> URL? {
        let urlString = String(format:"%@?q=%@&key=%@&pageSize=%@",
                               API_BASE_URL,
                               API_PRODUCT_QUERY,
                               API_KEY,
                               API_PAGE_SIZE)
        
        return URL(string: urlString)
    }
}

