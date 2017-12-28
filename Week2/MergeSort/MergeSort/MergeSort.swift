//
//  MergeSort.swift
//  MergeSort
//
//  Created by Artem Babakhanyants on 28.12.17.
//  Copyright © 2017 Artem Babakhaniants. All rights reserved.
//

import Foundation

func mergeSort<T: Comparable>(array: [T]) -> [T] {
    if array.count <= 1 {
        return array
    }
    
    let middleIdx = array.index(array.startIndex, offsetBy: array.count / 2)
    let left = mergeSort(array: Array<T>(array[..<middleIdx]))
    let right = mergeSort(array: Array<T>(array[middleIdx...]))
    let merged = merge(left: left, right: right)
    
    return merged
}

func merge<T: Comparable>(left: Array<T>, right: Array<T>) -> Array<T> {
    
    var leftIdx = 0
    var rightIdx = 0
    var result = [T]()
    
    while result.count < left.count + right.count {
        if leftIdx < left.count && rightIdx < right.count {
            if left[leftIdx] < right[rightIdx] {
                result.append(left[leftIdx])
                leftIdx += 1
            } else {
                result.append(right[rightIdx])
                rightIdx += 1
            }
        } else if leftIdx >= left.count && rightIdx < right.count {
            result.append(contentsOf: right[rightIdx...])
        } else if rightIdx >= right.count && leftIdx < left.count {
            result.append(contentsOf: left[leftIdx...])
        }
    }
    
    return result
}
