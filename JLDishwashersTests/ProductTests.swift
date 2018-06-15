//
//  ProductTests.swift
//  JLDishwashersTests
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_allPropertiesAreSetCorrectlyForDefaultInitializer() {
        
        let price = ["was": "399.00",
                     "then1": "",
                     "then2": "",
                     "now": "349.00",
                     "uom": "",
                     "currency": "GBP"]
        
        let sut = Product(productId: "1000", price: price, title: "Bosch Dishwasher 2019", imageURLPath: "//johnlewis.scene7.com/is/image/1000.jpg")
        
        XCTAssertEqual(sut.productId, "1000")
        XCTAssertEqual(sut.price["was"], "399.00")
        XCTAssertEqual(sut.price["then1"], "")
        XCTAssertEqual(sut.price["then2"], "")
        XCTAssertEqual(sut.price["now"], "349.00")
        XCTAssertEqual(sut.price["currency"], "GBP")
        XCTAssertEqual(sut.title, "Bosch Dishwasher 2019")
        XCTAssertEqual(sut.imageURLPath, "//johnlewis.scene7.com/is/image/1000.jpg")
    }
}
