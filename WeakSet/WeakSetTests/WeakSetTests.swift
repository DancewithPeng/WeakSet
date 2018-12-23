//
//  WeakSetTests.swift
//  WeakSetTests
//
//  Created by DancewithPeng on 2018/12/23.
//  Copyright © 2018 DP. All rights reserved.
//

import XCTest
import UIKit
@testable import WeakSet

class WeakTester: Hashable, Equatable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sayHi() {
        print("My Name is \(name)")
    }
    
    func hash(into hasher: inout Hasher) {
        name.hash(into: &hasher)
    }
    
    static func == (lhs: WeakTester, rhs: WeakTester) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

class WeakSetTests: XCTestCase {
    
    let aa = WeakTester(name: "aa")
    let bb = WeakTester(name: "bb")
    
    var set = WeakSet<WeakTester>()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let t1 = WeakTester(name: "111")
        let t2 = WeakTester(name: "222")
        let t3 = WeakTester(name: "333")
        let t4 = WeakTester(name: "444")
        
        
        
        // inset
        set.insert(t1)
        set.insert(t2)
        set.insert(t3)
        set.insert(t4)
        
        set.insert(aa)
        set.insert(bb)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        set.enumerateValidElements { (tester) in
            tester.sayHi()
        }
    }
    
    func testUIElement() {
        
        var uiElementSet = WeakSet<UIView>()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        uiElementSet.insert(label)
        
        uiElementSet.enumerateValidElements { (view) in
            view.backgroundColor = UIColor.blue
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
