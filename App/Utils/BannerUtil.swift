//
//  BannerUtil.swift
//  横幅消息工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation


class BannerUtil
{
    fileprivate static let kDisplayDuration: TimeInterval = 1.6
    
    
    static func showInfo(_ title: String, subtitle: String? = nil, image: UIImage? = nil, duration: TimeInterval? = kDisplayDuration, didTapBlock: (() -> ())? = nil)
    {
        show(title, subtitle: subtitle, image: image, backgroundColor: Colors.bannerInfoBg, duration: duration, didTapBlock: didTapBlock)
    }
    
    
    static func showWarning(_ title: String, subtitle: String? = nil, image: UIImage? = nil, duration: TimeInterval? = kDisplayDuration, didTapBlock: (() -> ())? = nil)
    {
        show(title, subtitle: subtitle, image: image, backgroundColor: Colors.bannerWarningBg, duration: duration, didTapBlock: didTapBlock)
    }

    
    static func show(_ title: String, subtitle: String? = nil, image: UIImage? = nil, backgroundColor: UIColor = Colors.bannerInfoBg, duration: TimeInterval? = kDisplayDuration, didTapBlock: (() -> ())? = nil)
    {
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: backgroundColor, didTapBlock: didTapBlock)
        banner.show(duration: duration)
    }
}
