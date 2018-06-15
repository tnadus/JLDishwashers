//
//  PriceTests.swift
//  JLDishwashersTests
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class PriceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_allPropertiesAreSetCorrectlyForDefaultInitializer() {
        let sut = Price(was: "399.00", now: "349.00", currency: "GBP")
        XCTAssertEqual(sut.was, "399.00")
        XCTAssertEqual(sut.now, "349.00")
        XCTAssertEqual(sut.currency, "GBP")
    }
    
}
