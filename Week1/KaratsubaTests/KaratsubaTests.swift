//
//  KaratsubaTests.swift
//  KaratsubaTests
//
//  Created by Artem Babakhanyants on 28.12.17.
//  Copyright © 2017 Artem Babakhaniants. All rights reserved.
//

import XCTest

class KaratsubaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAssignmentTaskCalculatesCorrectly() {
        let myOne = MyInt("3141592653589793238462643383279502884197169399375105820974944592")
        let myTwo = MyInt("2718281828459045235360287471352662497757247093699959574966967627")
        let product = MyInt("8539734222673567065463550869546574495034888535765114961879601127067743044893204848617875072216249073013374895871952806582723184")
        XCTAssertEqual(myOne * myTwo, product)
    }
    
    func testSimpleProductCalculatedCorrectly() {
        let examples = [
            ("9", "900", "8100"),
            ("1", "1", "1"),
            ("0", "1", "0"),
            ("100", "5", "500"),
            ("1000000", "10", "10000000"),
            ]
        
        for example in examples {
            let one = MyInt(example.0)
            let two = MyInt(example.1)
            let product = MyInt(example.2)
            XCTAssertEqual(one * two, product)
            XCTAssertEqual(two * one, product)
        }
    }
    
    func testAdditionOfTwoIntsCalculatesCorrectly() {
        let examples = [
            ("100", "100", "200"),
            ("100", "0", "100"),
            ("100", "99", "199"),
            ("0", "0", "0"),
            ("400", "600", "1000")
        ]
        
        for example in examples {
            let one = MyInt(example.0)
            let two = MyInt(example.1)
            let sum = MyInt(example.2)
            XCTAssertEqual(one + two, sum)
            XCTAssertEqual(two + one, sum)
        }
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
