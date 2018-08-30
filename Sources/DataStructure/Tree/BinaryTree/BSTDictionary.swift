//
//  BSTDictionary.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 8/30/18.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BSTKeyValueExample: XCTestCase {
    
    func test() {
        
        var dictionary = BSTDictionary(key: "7", value: 7)
        dictionary["4"] = 4
        dictionary["8"] = 8
        dictionary["1"] = 1
        dictionary["5"] = 5
        dictionary["0"] = 0
        dictionary["2"] = 2
        dictionary["4"] = 4
        dictionary["3"] = 3
        dictionary["6"] = 6
        
        var keys = [String]()
        var values = [Int]()
        
        dictionary.inOrder { key, value in
            keys.append(key)
            values.append(value)
        }
        
        for item in 0...8 {
            XCTAssert(values[item] == item)
            XCTAssert(keys[item] == String(item))
        }
    }
}

struct BSTDictionary<Key: Comparable, Value> {
    
    private var root: Node?
    
    init() {}
    
    init(key: Key, value: Value) {
        self.root = Node(key, value)
    }
    
    private class Node {
        var key: Key
        var value: Value
        var left: Node?
        var right: Node?
        
        init(_ key: Key, _ value: Value) {
            self.key = key
            self.value = value
        }
        
        func inOrder(_ block: Traverse) {
            left?.inOrder(block)
            block(key, value)
            right?.inOrder(block)
        }
    }
}

extension BSTDictionary {
    
    mutating func put(_ value: Value, for key: Key) {
        root = put(value: value, key: key, node: root)
    }
    
    private func put(value: Value, key: Key, node: Node?) -> Node {
        guard let node = node else { return Node(key, value) }
        
        if key < node.key {
            node.left = put(value: value, key: key, node: node.left)
        } else if key > node.key {
            node.right = put(value: value, key: key, node: node.right)
        } else {
            node.value = value
        }
        
        return node
    }
}

extension BSTDictionary {
    
    func value(for key: Key) -> Value? {
        return value(for: key, node: root)
    }
    
    private func value(for key: Key, node: Node?) -> Value? {
        guard let node = node else { return nil }
        
        if key < node.key {
            return value(for: key, node: node.left)
        } else if key > node.key {
            return value(for: key, node: node.right)
        } else {
            return node.value
        }
    }
}

extension BSTDictionary {
    
    mutating func delete(_ key: Key) {
        root = delete(key, node: root)
    }
    
    private func delete(_ key: Key, node: Node?) -> Node? {
        guard let node = node else { return nil }
        
        if key < node.key {
            node.left = delete(key, node: node.left)
        } else if key > node.key {
            node.right = delete(key, node: node.right)
        }
        
        guard let left = node.left else { return nil }
        
        let maxNode = max(node: left)
        maxNode.right = node.right
        return maxNode /// maxNode will become a new parent
    }
    
    private func max(node: Node) -> Node {
        guard let maxNode = node.right else { return node }
        return max(node: maxNode)
    }
}

extension BSTDictionary {

    subscript(key: Key) -> Value? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                put(value, for: key)
            } else {
                delete(key)
            }
        }
    }
}

extension BSTDictionary {
    
    typealias Traverse = (Key, Value) -> ()
    
    func inOrder(_ block: Traverse) {
        root?.inOrder(block)
    }
}