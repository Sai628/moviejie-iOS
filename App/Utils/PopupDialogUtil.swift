//
//  PopupDialogUtil.swift
//  弹出窗口工具类
//
//  Created by Sai on 19/04/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions


class PopupDialogUtil
{
    static func show(in viewController: UIViewController, title: String, message: String? = nil, gestureDismissal: Bool = true, buttons: [PopupDialogButton])
    {
        setupCustomStyle()
        
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: gestureDismissal)
        popup.addButtons(buttons)
        viewController.present(popup, animated: true, completion: nil)
    }
    
    
    static func setupCustomStyle()
    {
        let dialogAppearance = PopupDialogDefaultView.appearance()
        dialogAppearance.titleFont = UIFont.systemFont(ofSize: 17)
        dialogAppearance.titleColor = Colors.dialogTitle
        
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.color = UIColor.black
        overlayAppearance.opacity = 0.3
        overlayAppearance.blurEnabled = false
        
        let defaultButtonAppearance = DefaultButton.appearance()
        defaultButtonAppearance.titleFont = UIFont.systemFont(ofSize: 17)
        defaultButtonAppearance.titleColor = Colors.dialogDefaultButton
        
        let cancelButtonAppearance = CancelButton.appearance()
        cancelButtonAppearance.titleFont = UIFont.systemFont(ofSize: 17)
        cancelButtonAppearance.titleColor = Colors.dialogCancelButton
        
        let destructiveButtonAppearance = DestructiveButton.appearance()
        destructiveButtonAppearance.titleFont = UIFont.systemFont(ofSize: 17)
        destructiveButtonAppearance.titleColor = Colors.dialogDestructiveButton
    }
}
