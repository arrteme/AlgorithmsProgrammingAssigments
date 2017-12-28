//
//  Kek.swift
//  mah
//
//  Created by Artem Babakhanyants on 11.12.17.
//  Copyright © 2017 Artem Babakhaniants. All rights reserved.
//

import Foundation

struct MyInt: Equatable {
    fileprivate var stringValue: String
    fileprivate var count: Int {
        return stringValue.count
    }
    
    init(_ stringValue: String) {
        self.stringValue = stringValue
    }
    
    init(_ intValue: Int) {
        self.stringValue = String(intValue)
    }
    
    fileprivate mutating func fillWithLeadingZeroesToMatchLength(with other: inout MyInt) {
        let diff = abs(self.count - other.count)
        guard diff != 0 else {
            return
        }
        
        if self.count < other.count {
            self.appendLeadingZeroes(number: diff)
        } else {
            other.appendLeadingZeroes(number: diff)
        }
    }
    
    private mutating func appendLeadingZeroes(number: Int) {
        let zeroesString = String.init(repeating: "0", count: number)
        self.stringValue.insert(contentsOf: zeroesString, at: self.stringValue.startIndex)
    }
    
    fileprivate mutating func appeningTrailingZeroes(number: Int) -> MyInt {
        var result = MyInt(self.stringValue)
        let zeroesString = String.init(repeating: "0", count: number)
        result.stringValue.insert(contentsOf: zeroesString, at: result.stringValue.endIndex)
        return result
    }
    
    fileprivate func splitAtMiddle() -> (leftPart: MyInt, rightPart: MyInt) {
        let middleIdx = stringValue.index(stringValue.startIndex, offsetBy: self.count / 2)
        return (MyInt(String(self.stringValue[..<middleIdx])),
                MyInt(String(self.stringValue[middleIdx...])))
    }
    
    fileprivate func removingLeadingZeroes() -> MyInt {
        guard let nonZeroCharIdx = self.stringValue.index(where: { (char) -> Bool in
            char != "0"
        }) else {
            return MyInt(self.stringValue)
        }
        
        return MyInt(String(self.stringValue[nonZeroCharIdx...]))
    }
}

extension MyInt: CustomStringConvertible {
    var description: String {
        return self.stringValue
    }
}

// MARK: Overloading operators

func +(lhs: MyInt, rhs: MyInt) -> MyInt {
    
    var one, two: MyInt
    (one, two) = (lhs, rhs)
    
    one.fillWithLeadingZeroesToMatchLength(with: &two)
    
    let zipped = zip(one.stringValue.reversed(), two.stringValue.reversed())
    
    var carry = 0
    var otvet = String(zipped.reduce("") { (partail, tuple) -> String in
        let f, s: Int
        (f, s) = (Int(String(tuple.0))!, Int(String(tuple.1))!)
        let res = (f + s + carry) % 10
        carry = (f + s + carry) / 10
        return partail + String(res)
        }.reversed())
    
    if carry > 0 {
        otvet.insert("1", at: otvet.startIndex)
    }
    
    
    return MyInt(otvet)
}

func -(lhs: MyInt, rhs: MyInt) -> MyInt {
    
    var one = lhs
    var two = rhs
    
    one.fillWithLeadingZeroesToMatchLength(with: &two)
    
    let zipped = zip(one.stringValue.reversed(), two.stringValue.reversed())
    
    var carry = false
    let answer = zipped.reduce("") { (partail, tuple) -> String in
        var f = Int(String(tuple.0))!
        let s = Int(String(tuple.1))!
        
        if carry {
            f -= 1
        }
        
        if f < s {
            carry = true
            f += 10
        } else {
            carry = false
        }
        
        let res = f - s
        
        return partail + String(res)
        }.reversed()
    
    if let subAnswerIdx = answer.index(where: { (char) -> Bool in
        char != "0"
    }) {
        return MyInt(String(answer[subAnswerIdx...]))
    } else {
        return MyInt("0")
    }
}

func *(lhs: MyInt, rhs: MyInt) -> MyInt {
    guard lhs.count > 1 && rhs.count > 1 else {
        let f_int = Int(lhs)!
        let s_int = Int(rhs)!
         return MyInt(f_int * s_int)
    }
    
    var left = lhs
    var right = rhs
    
    left.fillWithLeadingZeroesToMatchLength(with: &right)
    
    var x1, x0, y1, y0: MyInt
    (x1, x0) = left.splitAtMiddle()
    (y1, y0) = right.splitAtMiddle()
    
    let m = x0.count
    
    var z2 = x1 * y1
    let z0 = x0 * y0
    var z1 = (x1 + x0) * (y1 + y0) - z2 - z0
    let product = z2.appeningTrailingZeroes(number: 2*m) + z1.appeningTrailingZeroes(number: m) + z0
    
    return product.removingLeadingZeroes()
}

// MARK: - Conforming to Equatable

func ==(lhs: MyInt, rhs: MyInt) -> Bool {
    return lhs.stringValue == rhs.stringValue
}

// MARK: - Private Int Extension for custom initializer

private extension Int {
    init?(_ myInt: MyInt) {
        self.init(myInt.stringValue)
    }
}
