//
//  Dimens.swift
//  尺寸常量值
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import EZSwiftExtensions


typealias DimenFloat = CGFloat

struct Dimens
{
    //-----------------  font size ------------------//
    static let fontSizeMicro: DimenFloat        = 10
    static let fontSizeTiny: DimenFloat         = 12
    static let fontSizeSmall: DimenFloat        = 14
    static let fontSizeNormal: DimenFloat       = 16
    static let fontSizeMiddle: DimenFloat       = 18
    static let fontSizeLarge: DimenFloat        = 22
    
    static let iphone4Width: DimenFloat         = 320
    static let iphone4Height: DimenFloat        = 480
    static let iphone5Width: DimenFloat         = 320
    static let iphone5Height: DimenFloat        = 568
    static let iphone6Width: DimenFloat         = 375
    static let iphone6Height: DimenFloat        = 667
    static let iphone6PlusWidth: DimenFloat     = 414
    static let iphone6PlusHeight: DimenFloat    = 736
    static let iphoneXWidth: DimenFloat         = 375
    static let iphoneXHeight: DimenFloat        = 812
    
    /// 安全区域的顶部间隔(在 iPhoneX 下为44. 在其它设备下为0)
    static let safeAreaTop: DimenFloat = (Display.currentType == .iphoneX ? 44 : 0)
    /// 安全区域的底部间隔(在 iPhoneX 下为34. 在其它设备下为0)
    static let safeAreaBottom: DimenFloat = (Display.currentType == .iphoneX ? 34 : 0)
    /// 页面顶部导航栏的高度(默认为带标题的布局)
    static let navBarHeight: DimenFloat  = (Display.currentType == .iphoneX ? 88 : 64)
    /// 页面除开顶部导航栏外的高度
    static let screenHeightWithouNavBar: DimenFloat = ez.screenHeight - navBarHeight
    
    /// 页面除开顶部导航栏外的 Rect(默认为带标题的导航栏)
    static let screenFrameWithoutNavBar: CGRect = CGRect(x: 0, y: navBarHeight,
                                                         width: ez.screenWidth,
                                                         height: ez.screenHeight - navBarHeight - safeAreaBottom)
    
    /// 页面底部TabBar的高度
    static let tabBarHeight: DimenFloat = 49
}
