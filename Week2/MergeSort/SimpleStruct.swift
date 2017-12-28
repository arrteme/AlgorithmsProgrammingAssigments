//
//  SimpleStruct.swift
//  MergeSort
//
//  Created by Artem Babakhanyants on 28.12.17.
//  Copyright © 2017 Artem Babakhaniants. All rights reserved.
//

import Foundation

struct Employee {
    let id: Int
    let name: String
}

extension Employee: Comparable {
    
}

func <(lhs: Employee, rhs: Employee) -> Bool {
    if lhs.name == rhs.name {
        return lhs.id < rhs.id
    } else {
        return lhs.name < rhs.name
    }
}

func ==(lhs: Employee, rhs: Employee) -> Bool {
    return lhs.id == rhs.id
}
