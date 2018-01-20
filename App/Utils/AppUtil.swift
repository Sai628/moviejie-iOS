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
    
    
    static func readOSTInfo(_ viewController: UIViewController, _ ostLink: String)
    {
        let ostInfoVC = OSTInfoVC()
        ostInfoVC.ostLink = ostLink
        viewController.pushVC(ostInfoVC)
    }
    
    
    static func open(scheme: String, completion: @escaping (Bool)-> Void)
    {
        guard let url = URL(string: scheme) else {
            completion(false)
            return
        }
        
        if #available(iOS 10, *)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: { (isSuccess) in
                completion(isSuccess)
            })
        }
        else
        {
            let result = UIApplication.shared.openURL(url)
            completion(result)
        }
    }
}
