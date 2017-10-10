//
//  UITextField+Extensions.swift
//  UITextField 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension UITextField
{
    convenience init(fontSize: CGFloat, colorInt: ColorInt, isBold: Bool = false)
    {
        self.init(fontSize: fontSize, textColor: colorInt.toColor(), isBold: isBold)
    }
    
    
    convenience init(fontSize: CGFloat, textColor: UIColor, isBold: Bool = false)
    {
        self.init()
        self.font = isBold ? UIFont.boldSystemFont(ofSize: fontSize) : UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
    }
}
