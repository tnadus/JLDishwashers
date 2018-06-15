//
//  JLProductsAPI.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation

/// Beautiful form of success callback handler used in JLProductsAPI
typealias FetchProductsCallback = ([Product]) -> Void
/// Beautiful form of failure callback handler used in JLProductsAPI
typealias FetchProductsErrorCallback = (Error) -> Void

/// Interface for providing productlist
protocol JLProductsAPI {
    func fetchProductList(onSuccess: FetchProductsCallback?,
                        onError: FetchProductsErrorCallback?)
}
