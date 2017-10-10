//
//  Int64+Extensions.swift
//  Int64 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension Int64
{
    /// From Sai: Returns an NSDate object initialized relative to 00:00:00 UTC on 1 January 1970 by using the Int64 value as a given number of seconds.
    func toDate() -> Date
    {
        return Date(timeIntervalSince1970: Double(self))
    }
    
    
    func toColor() -> UIColor
    {
        return UIColor(red: CGFloat((self & 0x00FF0000) >> 16) / 255.0,
                       green: CGFloat((self & 0x0000FF00) >> 8) / 255.0,
                       blue: CGFloat(self & 0x000000FF) / 255.0,
                       alpha: CGFloat((self & 0xFF000000) >> 24) / 255.0)
    }
}
