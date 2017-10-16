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
    
    
    static func readMovieInfo(_ viewController: UIViewController, _ movieLink: String)
    {
        let movieInfoVC = MovieInfoVC()
        movieInfoVC.movieLink = movieLink
        viewController.pushVC(movieInfoVC)
    }
    
    
    static func readLinkInfo(_ viewController: UIViewController, _ link: String)
    {
        let linkInfoVC = LinkInfoVC()
        linkInfoVC.link = link
        viewController.pushVC(linkInfoVC)
    }
}
