//
//  charIterator.swift
//  倉頡字典2356
//
//  Created by Qwetional on 19/9/2019.
//  Copyright © 2019 Qwetional. All rights reserved.
//

import Foundation

public class CharIterator:NSObject {
    @objc static func charIterator(targetString:NSString) -> NSMutableArray {
        let resultArr:NSMutableArray = NSMutableArray.init()
        let tempString = targetString.lowercased
        for ch in (tempString as String) {
            resultArr.add("\(ch)" as NSString)
        }
        return resultArr
    }
}
