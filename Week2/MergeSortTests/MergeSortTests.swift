//
//  MergeSortTests.swift
//  MergeSortTests
//
//  Created by Artem Babakhanyants on 28.12.17.
//  Copyright © 2017 Artem Babakhaniants. All rights reserved.
//

import XCTest

class MergeSortTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMergeDoesMergesCorrectly() {
        let examples = [
            ([1, 2, 3, 4, 5], [6, 7, 8, 9]),
            ([1, 3, 5, 7], [1, 3, 5, 7]),
            ([1, 1, 1, 10], [0, 11, 11, 11]),
            ([9, 11, 23], [1, 2, 3]),
        ]
        
        examples.forEach { (first, second) in
            let sortedNatively = [first, second].flatMap({ $0 }).sorted()
            XCTAssertEqual(merge(left: first, right: second), sortedNatively)
        }
        
        for example in examples {
            var sortedNatively = example.0
            sortedNatively.append(contentsOf: example.1)
            sortedNatively = sortedNatively.sorted()
            
            XCTAssertEqual(merge(left: example.0, right: example.1), sortedNatively)
        }
    }
    
    func testMergeSortSortsArrayCorrectly() {
        let examples = [
            [1, 2, 3],
            [1, 7, 2],
            [1000, 10, 1],
            [11, 11, 5, 11, 11],
            [0, 2, 6, 5, 4],
            [8],
            [1, 10],
        ]
        
        examples.forEach { example in
            XCTAssertEqual(mergeSort(array: example), example.sorted())
            XCTAssertEqual(mergeSort(array: example.reversed()), example.sorted())
        }
    }
    
    func testMergeSortSortsArrayOfCustomComparableStructs() {
        let john1 = Employee(id: 1, name: "John")
        let joseph2 = Employee(id: 2, name: "Joseph")
        let jesus3 = Employee(id: 3, name: "Jesus")
        let artem4 = Employee(id: 4, name: "Artem")
        let john5 = Employee(id: 5, name: "John")
        let employees = [john1, joseph2, jesus3, artem4, john5]
        
        XCTAssertEqual(mergeSort(array: employees), [artem4, jesus3, john1, john5, joseph2])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
