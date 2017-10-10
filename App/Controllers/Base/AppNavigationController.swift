//
//  AppNavigationController.swift
//  应用基本导航控制器
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit


class AppNavigationController: UINavigationController
{
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        return .`default`
    }
    
    
    override var prefersStatusBarHidden : Bool
    {
        return false
    }
}
