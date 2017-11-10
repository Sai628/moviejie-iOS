//
//  MainVC.swift
//  "首页"视图
//
//  Created by Sai on 23/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MainVC: UITabBarController
{
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initView()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        
        let newestInfoVC = NewestInfoVC()
        newestInfoVC.tabBarItem = UITabBarItem(title: "更新",
                                         image: UIImage(named: R.icon_new_normal),
                                         selectedImage: UIImage(named: R.icon_new_highlight))
        let newMovieVC = NewMovieVC()
        newMovieVC.tabBarItem = UITabBarItem(title: "电影",
                                         image: UIImage(named: R.icon_movie_normal),
                                         selectedImage: UIImage(named: R.icon_movie_highlight))
        let newTvVC = NewTvVC()
        newTvVC.tabBarItem = UITabBarItem(title: "电视剧",
                                         image: UIImage(named: R.icon_tv_normal),
                                         selectedImage: UIImage(named: R.icon_tv_highlight))
        
        let newOSTVC = NewOSTVC()
        newOSTVC.tabBarItem = UITabBarItem(title: "原声大碟",
                                           image: UIImage(named: R.icon_ost_normal),
                                           selectedImage: UIImage(named: R.icon_ost_highlight))
        
        self.viewControllers = [newestInfoVC, newMovieVC, newTvVC, newOSTVC]
        
        let searchBtn = UIButton(type: .custom)
        searchBtn.frame = CGRect(x: 0, y: 0, w: 40, h: 40)
        searchBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        searchBtn.setImage(UIImage(named: R.icon_search_normal), for: .normal)
        searchBtn.setImage(UIImage(named: R.icon_search_highlight), for: .highlighted)
        searchBtn.addTarget(self, action: #selector(doSearch), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    }
    
    
    //MARK:- HANDLER
    func doSearch()
    {
        pushVC(SearchVC())
    }
}
