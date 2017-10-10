//
//  UIView+Extensions.swift
//  UIView 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension UIView
{
    convenience init(backgroundColorInt: ColorInt)
    {
        self.init(backgroundColor: backgroundColorInt.toColor())
    }
    
    
    convenience init(backgroundColor: UIColor)
    {
        self.init()
        self.backgroundColor = backgroundColor
    }
}
