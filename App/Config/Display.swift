//
//  Display.swift
//  设备显示类型
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions


class Display
{
    enum DisplayType
    {
        case iphone4        // 4 | 4S @2x
        case iphone5        // 5 | 5S | SE @2x
        case iphone6        // 6 | 6S | 7 | 8 @2x
        case iphone6Plus    // 6Plus | 6s Plus | 7Plus | 8Plus @3x
        case iphoneX        // X | XS @3x
        case iphoneXR       // XR @2x | XS Max @3x
    }

    
    class var currentType: DisplayType
    {
        switch (ez.screenWidth, ez.screenHeight)
        {
        case (Dimens.iphone4Width, Dimens.iphone4Height):
            return .iphone4
        case (Dimens.iphone5Width, Dimens.iphone5Height):
            return .iphone5
        case (Dimens.iphone6Width, Dimens.iphone6Height):
            return .iphone6
        case (Dimens.iphone6PlusWidth, Dimens.iphone6PlusHeight):
            return .iphone6Plus
        case (Dimens.iphoneXWidth, Dimens.iphoneXHeight):
            return .iphoneX
        case (Dimens.iphoneXRWidth, Dimens.iphoneXRHeight):
            return .iphoneXR
        default:
            return .iphone6Plus  // 默认返回 iPhone6 Plus 的设备类型
        }
    }
    
    
    static func isIPhoneXSeries() -> Bool
    {
        return (currentType == .iphoneX || currentType == .iphoneXR)
    }
}
