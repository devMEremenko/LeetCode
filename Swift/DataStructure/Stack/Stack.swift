//
//  Stack.swift
//  CodingChallenges
//
//  Created by Maxim Eremenko on 6/13/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class StackTests: XCTestCase {
    
    func test() {
        
    }
}

struct Stack<Item> {
    
    ///TODO: Tests
    
    private var list = List<Item>()
    private(set) var size = 0
    
    init() {}
    
    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == Item {
        size = sequence.underestimatedCount
        for item in sequence {
            list.addTo(start: item)
        }
    }

    init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Item, value: Int) {
        size = sequence.underestimatedCount
        for (item, _) in sequence {
            list.addTo(start: item)
        }
    }
    
    mutating func push(_ item: Item) {
        size += 1
        list.addTo(start: item)
    }
    
    @discardableResult
    mutating func pop() -> Item? {
        size = size > 0 ? size - 1 : 0 
        return list.removeFirst()
    }
    
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    var top: Item? {
        return list.first
    }
}

extension Stack where Item: Equatable {
    
    static func == (left: Stack<Item>, right: Stack<Item>) -> Bool {
        return left.list == right.list
    }
}

extension Stack {
    
    /// Note: These methods are implmented in order to support kind of some solutions.
    
    var back: Item? {
        return list.last
    }
    
    @discardableResult
    mutating func popBack() -> Item? {
        size = size > 0 ? size - 1 : 0
        return list.removeLast()
    }
}
