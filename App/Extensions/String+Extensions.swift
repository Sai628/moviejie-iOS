//
//  String+Extensions.swift
//  String 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import EZSwiftExtensions


extension String
{
    /// From Sai: Calculate String height dynamically
    func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode? = nil) -> CGFloat
    {
        var attrib: [String: AnyObject] = [NSFontAttributeName: font]
        if lineBreakMode != nil
        {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSParagraphStyleAttributeName)
        }
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attrib, context: nil).height)
    }
    
    
    /// From Sai: Calculate String width dynamically
    func width(_ height: CGFloat, font: UIFont) -> CGFloat
    {
        let attrib: [String: AnyObject] = [NSFontAttributeName: font]
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        return ceil((self as NSString).boundingRect(with: size, attributes: attrib, context: nil).width)
    }

    
    /// From Sai: Converts String to Int64
    func toInt64() -> Int64
    {
        return (self as NSString).longLongValue
    }
    
    
    /**
     From Sai: Converts String with format "yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd" or "HH:mm:ss" to NSDate
     
     if String with format "yyyy-MM-dd", will return "yyyy-MM-dd 00:00:00" in NSDate
     
     if String with format "HH:mm:ss", will return "2000-01-01 HH:mm:ss" in NSDate
     */
    func toDate() -> Date!
    {
        if let date = Date(fromString: self, format: "yyyy-MM-dd HH:mm:ss")
        {
            return date
        }
        
        if let date = Date(fromString: self, format: "yyyy-MM-dd")
        {
            return date
        }
        
        if let date = Date(fromString: self, format: "HH:mm:ss")
        {
            return date
        }
        
        return nil
    }
}
