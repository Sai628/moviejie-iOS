//
//  Global.swift
//  全局变量/方法
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import Cache
import XCGLogger


let log = XCGLogger.default
let apiStorage = try! Storage(diskConfig: DiskConfig(name: "api-storage", expiry: .date(Date().addingTimeInterval(Constant.CACHE_EXPIRE_TIME))),
                            memoryConfig: MemoryConfig(expiry: .date(Date().addingTimeInterval(Constant.CACHE_EXPIRE_TIME)),
                              countLimit: 500,
                          totalCostLimit: 0))


func synchronized(_ lock: AnyObject!, closure:() -> ())
{
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
