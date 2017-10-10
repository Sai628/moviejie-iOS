//
//  UILabel+Extensions.swift
//  UILabel 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


extension UILabel
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
    
    
    func addTextSpacing(_ spaceValue: CGFloat)
    {
        if let textString = text
        {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSKernAttributeName, value: spaceValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
