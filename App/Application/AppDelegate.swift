//
//  AppDelegate.swift
//  应用委托(程序入口)
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation

import EZSwiftExtensions
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var navigationController: AppNavigationController!
    
    
    //MARK:- LIFE CYCLE
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        initLogger()
        initKeyboardManager()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        goToMainVC()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void)
    {
        guard let rootNav = window?.rootViewController as? AppNavigationController else {
            return
        }
        
        switch shortcutItem.type
        {
        case "search":  // "搜索"菜单
            if !(rootNav.viewControllers.last is SearchVC)
            {
                rootNav.viewControllers.last?.pushVC(SearchVC())
            }
        default:
            break
        }
    }
}


//MARK:- EXTENSION 
//MARK: INIT
extension AppDelegate
{
    fileprivate func initLogger()
    {
        #if DEBUG
            log.setup(level: .debug, showLogIdentifier: false, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: false, writeToFile: nil, fileLevel: .debug)
        #else
            log.setup(level: .severe, showLogIdentifier: false, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel: nil)
        #endif
    }
    
    
    fileprivate func initKeyboardManager()
    {
        let manager = IQKeyboardManager.shared
        manager.enable = true
        manager.shouldResignOnTouchOutside = true
        manager.shouldToolbarUsesTextFieldTintColor = true
    }
}
    

//MARK: GOTO
extension AppDelegate
{
    func goToMainVC()
    {
        let mainVC = MainVC()
        changeRootVC(to: mainVC)
    }
    
    
    fileprivate func changeRootVC(to viewController: UIViewController)
    {
        navigationController?.removeFromParentViewController()
        navigationController = nil
        
        let rootNavController = AppNavigationController(rootViewController: viewController)
        navigationController = rootNavController
        navigationController.isNavigationBarHidden = false
        
        window?.rootViewController = navigationController
        window?.removeSubviews()
        window?.addSubview(navigationController.view)
    }
}
