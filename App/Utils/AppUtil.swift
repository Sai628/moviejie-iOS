//
//  AppUtil.swift
//  应用工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions


struct AppUtil
{
    static var appDelegate: AppDelegate
    {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    
    
    static func readMovieInfo(_ viewController: UIViewController, _ resourceInfo: ResourceInfo)
    {
        let movieInfoVC = MovieInfoVC()
        movieInfoVC.resourceInfo = resourceInfo
        viewController.pushVC(movieInfoVC)
    }
}
