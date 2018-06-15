//
//  JLProductsAPI.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation

typealias FetchProductsCallback = ([Product]) -> Void
typealias FetchProductsErrorCallback = (Error) -> Void

protocol JLProductsAPI {
    func fetchProductList(onSuccess: FetchProductsCallback?,
                        onError: FetchProductsErrorCallback?)
}
