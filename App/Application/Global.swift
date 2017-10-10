//
//  Global.swift
//  全局变量/方法
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import XCGLogger


let log = XCGLogger.default


func synchronized(_ lock: AnyObject!, closure:() -> ())
{
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
