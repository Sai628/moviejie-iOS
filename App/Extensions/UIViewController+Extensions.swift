//
//  UIViewController+Extensions.swift
//  UIViewController 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import EZSwiftExtensions


extension UIViewController
{
    func app_keyboardManagerEnabled()
    {
        let manager = IQKeyboardManager.sharedManager()
        if !manager.enable
        {
            manager.enable = true
            manager.enableAutoToolbar = true
        }
    }
    
    
    func app_keyboardManagerDisabled()
    {
        let manager = IQKeyboardManager.sharedManager()
        if manager.enable
        {
            manager.enable = false
            manager.enableAutoToolbar = false
        }
    }
    
    
    func app_autoToolbarEnable()
    {
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }
    
    
    func app_autoToolbarDisabled()
    {
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }
}


extension UIViewController
{
    func addKeyboardDidChangeFrameNotification()
    {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidChangeFrame.rawValue, selector: #selector(UIViewController.keyboardDidChangeFrameNotification(_:)))
    }
    
    
    func removeKeyboardDidChangeFrameNotification()
    {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardDidChangeFrame.rawValue)
    }
    
    
    @objc func keyboardDidChangeFrameNotification(_ notification: Notification)
    {
        if let info = notification.userInfo, let value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue
        {
            let frame = value.cgRectValue
            keyboardDidChangeFrame(frame)
        }
    }
    
    
    func keyboardDidChangeFrame(_ frame: CGRect)
    {
    }
}
