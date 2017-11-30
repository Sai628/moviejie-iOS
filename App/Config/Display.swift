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
    /// iPhone7/8 与 iPhone6 的尺寸一致. 不需要再进行定义
    enum DisplayType
    {
        case iphone4
        case iphone5
        case iphone6
        case iphone6Plus
        case iphoneX
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
        default:
            return .iphone6Plus  // 默认返回 iPhone6 Plus 的设备类型
        }
    }
}
