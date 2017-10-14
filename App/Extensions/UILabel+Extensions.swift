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
    
    
    func setLineSpacing(lineSpacing: CGFloat, lineHeightMultiple: CGFloat = 0.0)
    {
        guard let labelText = self.text else {
            return
        }
        
        let attrString = NSMutableAttributedString(string: labelText)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        style.lineHeightMultiple = lineHeightMultiple
        attrString.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange(location: 0, length: labelText.length))
        self.attributedText = attrString
    }
}
