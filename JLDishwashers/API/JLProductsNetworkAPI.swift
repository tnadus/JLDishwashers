//
//  JLProductsNetworkAPI.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Error enumuration used for API callback
///
/// - productURLInvalid: URL can not be built correctly
/// - responseCodeInvalid: Response is empty or status code is other than 200
/// - responseDataInvalid: Response data is invalid
enum JLProductsNetworkAPIError: Error {
    case productURLInvalid(description: String)
    case responseCodeInvalid(description: String)
    case responseDataInvalid(description: String)
}

/// Concrete Data provider to deliver data in Product array
class JLProductsNetworkAPI: JLProductsAPI {
    
    //MARK: Properties
    let API_BASE_URL       = "https://api.johnlewis.com/v1/products/search"
    let API_KEY            = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
    let API_PRODUCT_QUERY  = "dishwasher"
    let API_PAGE_SIZE      = "20"
    
    /// Retrieve product list and inform the delegate with async callback
    ///
    /// - Parameters:
    ///   - onSuccess: Success response handler delivering data in Product array
    ///   - onError: Any error during fetch is handled including the error
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
    
    /// errorHandler
    ///
    /// - Parameters:
    ///   - error: Error enum
    ///   - handler: Error handler callback
    func errorHandler(_ error: Error, _ handler: FetchProductsErrorCallback?) {
        DispatchQueue.main.sync {
            handler?(error)
        }
    }
    
    /// Builds an url address with the paramaters
    ///
    /// - Returns: Product list URL object if successful
    func urlPathBuilder() -> URL? {
        let urlString = String(format:"%@?q=%@&key=%@&pageSize=%@",
                               API_BASE_URL,
                               API_PRODUCT_QUERY,
                               API_KEY,
                               API_PAGE_SIZE)
        
        return URL(string: urlString)
    }
}

