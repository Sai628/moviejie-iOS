//
//  ProgressUtil.swift
//  进度提醒工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation
import MBProgressHUD


class ProgressUtil
{
    fileprivate static let progressUtil = ProgressUtil()
    var hud: MBProgressHUD!
    
    
    deinit
    {
        ProgressUtil.progressUtil.hud?.removeFromSuperview()
        ProgressUtil.progressUtil.hud = nil
    }
    
    
    static func show(inView view: UIView, message: String)
    {
        for subView in view.subviews.reversed()
        {
            if let progressHub = (subView as? MBProgressHUD)
            {
                progressHub.label.text = message
                return
            }
        }
        
        progressUtil.hud = MBProgressHUD(view: view)
        view.addSubview(progressUtil.hud)
        
        progressUtil.hud.removeFromSuperViewOnHide = true
        progressUtil.hud.label.text = message
        progressUtil.hud.show(animated: true)
    }
    
    
    static func dismiss()
    {
        progressUtil.hud?.hide(animated: true)
    }
}
