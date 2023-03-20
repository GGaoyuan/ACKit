//
//  Dictionary_Extension.swift
//  ACKit
//
//  Created by gaoyuan on 2023/3/9.
//

import UIKit

extension Dictionary {
    
    public mutating func ac_merge<S:Sequence>(_ sequence: S)
    where S.Iterator.Element == (key: Key, value: Value) {
        sequence.forEach { self[$0] = $1 }
    }
    
}
