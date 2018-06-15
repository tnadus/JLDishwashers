//
//  ProductsParserTests.swift
//  JLDishwashersTests
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class ProductsParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_parseInvalidDataShouldReturnNil() {
        let products = ProductsParser.parse(data: Data(count: 0))
        XCTAssertNil(products)
    }
    
    func test_parseValidDataToProducts() {
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Products", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url )
        
        let products = ProductsParser.parse(data: data)!
        
        XCTAssertEqual(products.count, 20)
        XCTAssertEqual(products[0].productId, "3215462")
        XCTAssertEqual(products[0].title, "Bosch SMS25AW00G Freestanding Dishwasher, White")
        XCTAssertEqual(products[0].price.now, "349.00")
    }
}
