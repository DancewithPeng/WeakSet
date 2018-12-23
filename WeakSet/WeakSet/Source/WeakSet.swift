//
//  WeakSet.swift
//  WeakSet
//
//  Created by DancewithPeng on 2018/12/23.
//  Copyright © 2018 DP. All rights reserved.
//

import Foundation


/// 弱引用集合
public struct WeakSet<Element: AnyObject & Hashable> {
    
    /// 集合
    private lazy var set = Set<Weak<Element>>()
    
    
    /// 添加元素
    ///
    /// - Parameter element: 元素
    /// - Returns: 返回是否添加成功，以及添加的元素
    @discardableResult
    mutating public func insert(_ element: Element) -> (Bool, Element) {
        let (isSuccess, weakObj) = set.insert(Weak(object: element))
        return (isSuccess, weakObj.object ?? element)
    }
    
    /// 删除元素
    ///
    /// - Parameter element: 元素
    /// - Returns: 返回删除的元素
    @discardableResult
    mutating public func remove(_ element: Element) -> Element? {
        
        let index = set.firstIndex { (weak) -> Bool in
            return element == weak.object
        }
        
        guard let idx = index else {
            return nil
        }
        
        let result = set.remove(at: idx)
        return result.object
    }
    
    /// 删除所有元素
    public mutating func removeAll() {
        set.removeAll()
    }
    
    /// 遍历有效元素，每次便利会把无效的元素剔除
    ///
    /// - Parameter closure: 处理元素的闭包
    public mutating func enumerateValidElements(using closure: (Element) -> Void) {
        
        var removedElements = [Weak<Element>]()
        for weak in set {
            guard let element = weak.object else {
                removedElements.append(weak)
                continue
            }
            
            closure(element)
        }
        
        for removedElement in removedElements {
            set.remove(removedElement)
        }
    }
    
    /// 元素个数
    public mutating func count() -> Int {
        return set.count
    }
}


/// 弱引用对象
class Weak<Object: AnyObject & Hashable> {
    
    /// 唯一标识符，取内存地址
    private lazy var identifier: String = "\(Unmanaged.passUnretained(self).toOpaque())"
    
    /// 需要弱引用的对象
    weak var object: Object?
    
    
    // MARK: - Life Cycle
    
    init(object: Object?) {
        self.object = object
    }
}


// MARK: - Hashable
extension Weak: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        identifier.hash(into: &hasher)
    }
    
    public static func == (lhs: Weak, rhs: Weak) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

