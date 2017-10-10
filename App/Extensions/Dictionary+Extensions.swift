//
//  Dictionary+Extensions.swift
//  Dictionary 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import SwiftyJSON


extension Dictionary: JSONStringConvertible
{
    var jsonString: String
    {
        let json = JSON(self)
        return json.rawString(options: []) ?? ""
    }
}
