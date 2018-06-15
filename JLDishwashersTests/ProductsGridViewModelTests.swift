//
//  GridViewModel.swift
//  JLDishwashersTests
//
//  Created by Murat Sudan on 15.06.2018.
//  Copyright © 2018 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import JLDishwashers

class ProductsGridViewModelTests: XCTestCase {
    
    var sut: ProductsGridViewModel?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_titleIsSetCorrectlyOnSuccess() {
        let sut = ProductsGridViewModel(productsAPI: MockProductsAPI(success: true))
        let expect = expectation(description: "Waiting for data")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500)) {
            XCTAssertEqual(sut.title, "Dishwashers (3)")
            expect.fulfill()
        }

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_titleIsSetCorrectlyOnError() {
        let sut = ProductsGridViewModel(productsAPI: MockProductsAPI(success: false))
        let expect = expectation(description: "Waiting for data")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(500)) {
            XCTAssertEqual(sut.title, "Data can not be loaded")
            expect.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_cellSizeIsSetCorrectly() {
        let sut = ProductsGridViewModel(productsAPI: MockProductsAPI(success: true))
        let size = CGSize(width: 240, height: 330)
        XCTAssertEqual(sut.cellSize(width: size.width, height: size.height), size)
    }
    
    func test_cellTitleIsSetCorrectlyForValidData() {
        let sut = ProductsGridViewModel(productsAPI: MockProductsAPI(success: true))
        let indexPath = IndexPath(item: 0, section: 0)
        let title = sut.cellTitle(indexPath: indexPath)
        
        let attrsRegular = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        let attrsBold = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.black]
        let description = NSAttributedString(string: sut.products.value[indexPath.row].title + "\n", attributes: attrsRegular)
        let price = NSAttributedString(string: sut.products.value[indexPath.row].price.now + sut.products.value[indexPath.row].price.currency, attributes: attrsBold)
        let textAll = NSMutableAttributedString()
        textAll.append(description)
        textAll.append(price)
        
        XCTAssertEqual(title, textAll)
    }
            
    func test_loadImageGetsAnImageFromCache() {
        
        let expect = expectation(description: "Waiting for image")
        
        let sut = ProductsGridViewModel(productsAPI: MockProductsAPI(success: false))
        let urlString = "http://dummy.com/image.jpg"
        let img = UIImage(named: "test-image.jpg", in: Bundle(for: type(of: self)), compatibleWith: nil)
        sut.cache.setObject(img!, forKey: urlString as AnyObject)
        
        sut.loadImage(urlString: urlString) { (img) in
            XCTAssertNotNil(img)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_loadImageGetsAnImageFromValidUrl() {
        
        let expect = expectation(description: "Waiting for image")
        
        let sut = ProductsGridViewModel(productsAPI: MockProductsAPI(success: false))
        let urlString = "https:/johnlewis.scene7.com/is/image/JohnLewis/236888507?"
        
        sut.loadImage(urlString: urlString) { (img) in
            XCTAssertNotNil(img)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
    }
}

//MARK - Helper class & methods

extension ProductsGridViewModelTests {
    
    class MockProductsAPI: JLProductsAPI {
        
        let success:Bool
        
        init(success: Bool) {
            self.success = success
        }
        
        func fetchProductList(onSuccess: FetchProductsCallback?, onError: FetchProductsErrorCallback?) {
            
            if success {
                let price = Price(was: "120", now: "100", currency: "GBP")
                
                let products = [
                    Product(productId: "1000", price: price , title: "Dishwasher 1", imageURLPath: "imgpath"),
                    Product(productId: "1001", price: price , title: "Dishwasher 2", imageURLPath: "imgpath"),
                    Product(productId: "1002", price: price , title: "Dishwasher 3", imageURLPath: "imgpath")
                ]
                onSuccess?(products)
                
            } else {
                let err = NSError(domain: "error", code: 0, userInfo: nil)
                onError?(err)
            }
        }
    }
}

