//
//  ArrayUtil.swift
//  数组工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


struct ArrayUtil
{
    static func isEmpty<T>(_ array: [T]?) -> Bool
    {
        guard let arr = array else
        {
            return true
        }
        
        return arr.isEmpty
    }
    
    
    static func getSize<T>(_ array: [T]?) -> Int
    {
        guard let arr = array else
        {
            return 0
        }
        
        return arr.count
    }
}
