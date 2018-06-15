//
//  Dynamic.swift
//  JLDishwashers
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import Foundation

/// A container that accepts any type and informs the binder on change of value
class Dynamic<T> {
    
    //MARK: properties
    typealias NotifierBlock =  (T) -> Void
    var notifier: NotifierBlock?
    
    var value:T {
        didSet {
            notifier?(value)
        }
    }
    
    //MARK: Initializer
    init(value: T) {
        self.value = value
    }
    
    //MARK: Bind methods
    func bind(_ notifier:NotifierBlock?) {
        self.notifier = notifier
    }
    
    func bindAndFire(_ bindBlock: NotifierBlock?) {
        self.notifier = bindBlock
        notifier?(value)
    }
}
