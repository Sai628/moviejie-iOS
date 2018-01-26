//
//  NewestInfoVC.swift
//  "最新信息"视图
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation

import EZSwiftExtensions
import SnapKit


class NewestInfoVC: UIViewController
{
    fileprivate var refreshControl: ODRefreshControl!
    fileprivate var tableView: UITableView!
    fileprivate var loadingMenu: LoadingMenu!
 
    fileprivate var dataItems: [ResourceType] = []
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadingMenu.showLoading()
        loadNewestInfo()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.parent?.title = "更新"
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(NewResourceCell.self, forCellReuseIdentifier: NewResourceCell.className)
        tableView.register(HotResourceCell.self, forCellReuseIdentifier: HotResourceCell.className)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        refreshControl = ODRefreshControl(in: tableView)
        refreshControl.addTarget(self, action: #selector(refreshNewestInfo), for: .valueChanged)
        
        loadingMenu = LoadingMenu(frame: Dimens.screenFrameWithoutNavBar)
        loadingMenu.delegate = self
        view.addSubview(loadingMenu)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimens.navBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Dimens.tabBarHeight)
        }
    }
    
    
    func updateUI(data: [String: Any])
    {
        let news = data["news"] as! [ResourceType]
        let hots = data["hots"] as! [ResourceType]
        dataItems.removeAll()
        dataItems.append(contentsOf: news)
        dataItems.append(contentsOf: hots)
        tableView.reloadData()
    }
    
    
    //MARK:- ACTION
    func loadNewestInfo()
    {
        NetService.getIndexInfo(onError: { [weak self] (errorCode, errorMsg) in
            
            self?.loadingMenu.showFail()
            
        }, onFailure: { [weak self] (failureMsg) in
            
            self?.loadingMenu.showFail()
            
        }) { [weak self] (data) in
            
            self?.loadingMenu.dismiss()
            self?.updateUI(data: data as! [String: Any])
        }
    }
    
    
    @objc func refreshNewestInfo()
    {
        NetService.getIndexInfo(onError: { [weak self] (errorCode, errorMsg) in
            
            self?.refreshControl.endRefreshing()
            
        }, onFailure: { [weak self] (failureMsg) in
                
            self?.refreshControl.endRefreshing()
                
        }) { [weak self] (data) in
            
            self?.refreshControl.endRefreshing()
            self?.updateUI(data: data as! [String: Any])
        }
    }
}


//MARK:- LoadingMenuDelegate
extension NewestInfoVC: LoadingMenuDelegate
{
    func onRetryClicked(_ view: LoadingMenu)
    {
        loadNewestInfo()
    }
}


//MARK:- UITableViewDelegate
extension NewestInfoVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let resourceInfo = dataItems[indexPath.section].resources[indexPath.row]
        if !resourceInfo.movie_link.isBlank
        {
            AppUtil.readMovieInfo(self, resourceInfo.movie_link)
        }
        else if !resourceInfo.link.isBlank
        {
            AppUtil.readLinkInfo(self, resourceInfo.link)
        }
        else
        {
            BannerUtil.showWarning("未支持")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let dataItem = dataItems[indexPath.section]
        switch dataItem
        {
        case is NewInfo:
            return NewResourceCell.cellHeight
            
        case is HotInfo:
            return HotResourceCell.cellHeight
        
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 28
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.w, height: 28))
        headerView.backgroundColor = Colors.tableViewHeaderBg
        
        let label = UILabel(fontSize: 16, textColor: Colors.tableViewHeaderTitle, isBold: true)
        label.frame = CGRect(x: 16, y: 6, width: tableView.w - 16, height: 18)
        label.textAlignment = .left
        headerView.addSubview(label)
        
        let dataItem = dataItems[section]
        label.text = dataItem.category
        
        return headerView
    }
}


//MARK:- UITableViewDelegate
extension NewestInfoVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return dataItems.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataItems[section].resources.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell!
        
        switch dataItems[indexPath.section]
        {
        case is NewInfo:
            cell = getNewResourceCell(tableView, cellForRowAt: indexPath)
            
        case is HotInfo:
            cell = getHotResourceCell(tableView, cellForRowAt: indexPath)
            
        default:
            fatalError("type invalid")
        }
        
        tableView.addLineForCell(cell: cell, at: indexPath, leftSpace: 0, rightSpace: 0, hasSectionLine: false)
        return cell
    }
    
    
    func getNewResourceCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewResourceCell.className, for: indexPath) as! NewResourceCell
        cell.setModel(dataItems[indexPath.section].resources[indexPath.row])
        return cell
    }
    
    
    func getHotResourceCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotResourceCell.className, for: indexPath) as! HotResourceCell
        cell.setModel(dataItems[indexPath.section].resources[indexPath.row])
        return cell
    }
}
