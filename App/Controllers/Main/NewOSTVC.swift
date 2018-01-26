//
//  NewOSTVC.swift
//  "原声大碟"视图
//
//  Created by Sai on 26/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import ESPullToRefresh
import EZSwiftExtensions
import SnapKit


class NewOSTVC: UIViewController
{
    fileprivate var refreshControl: ODRefreshControl!
    fileprivate var tableView: UITableView!
    fileprivate var loadingMenu: LoadingMenu!
    
    fileprivate var dataItems: [OSTSimpleInfo] = []
    fileprivate var currentPage: Int = 1
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadingMenu.showLoading()
        loadNewOSTInfos()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.parent?.title = "原声大碟"
    }
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(NewOSTCell.self, forCellReuseIdentifier: NewOSTCell.className)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        let refreshFooter = MyRefreshFooterAnimator(frame: CGRect(x: 0, y: 0, w: ez.screenWidth, h: 68))
        tableView.es.addInfiniteScrolling(animator: refreshFooter) { [weak self] in
            self?.loadMoreOSTInfos()
        }
        view.addSubview(tableView)
        
        refreshControl = ODRefreshControl(in: tableView)
        refreshControl.addTarget(self, action: #selector(refreshNewOSTInfos), for: .valueChanged)
        
        loadingMenu = LoadingMenu(frame: Dimens.screenFrameWithoutNavBar)
        loadingMenu.delegate = self
        view.addSubview(loadingMenu)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimens.navBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Dimens.tabBarHeight)
        }
    }
    
    
    //MARK:- ACTION
    func loadNewOSTInfos()
    {
        NetService.getNewOST(page: "p1", onError: { [weak self] (errorCode, errorMsg) in
            
            self?.loadingMenu.showFail()
            
            }, onFailure: { [weak self] (failureMsg) in
                
                self?.loadingMenu.showFail()
                
        }) { [weak self] (data) in
            
            self?.loadingMenu.dismiss()
            guard let ostInfos = data as? [OSTSimpleInfo], ostInfos.count > 0 else {
                self?.loadingMenu.showEmpty()
                return
            }
            
            self?.currentPage = 2
            self?.dataItems = ostInfos
            self?.tableView.reloadData()
        }
    }
    
    
    @objc func refreshNewOSTInfos()
    {
        NetService.getNewOST(page: "p1", onError: { [weak self] (errorCode, errorMsg) in
            
            self?.refreshControl.endRefreshing()
            
            }, onFailure: { [weak self] (failureMsg) in
                
                self?.refreshControl.endRefreshing()
                
        }) { [weak self] (data) in
            
            self?.refreshControl.endRefreshing()
            guard let ostInfos = data as? [OSTSimpleInfo], ostInfos.count > 0 else {
                return
            }
            
            self?.currentPage = 2
            self?.dataItems = ostInfos
            self?.tableView.reloadData()
        }
    }
    
    
    func loadMoreOSTInfos()
    {
        NetService.getNewOST(page: "p\(currentPage)", onError: { [weak self] (errorCode, errorMsg) in
            
            self?.tableView.es.stopLoadingMore()
            
            }, onFailure: { [weak self] (failureMsg) in
                
                self?.tableView.es.stopLoadingMore()
                
        }) { [weak self] (data) in
            
            let ostInfos = data as! [OSTSimpleInfo]
            self?.dataItems.append(contentsOf: ostInfos)
            self?.tableView.reloadData()
            
            guard ostInfos.count >= 10 else {
                self?.tableView.es.stopLoadingMore()
                return
            }
            
            self?.tableView.es.stopLoadingMore()
            self?.currentPage += 1
        }
    }
}


//MARK:- LoadingMenuDelegate
extension NewOSTVC: LoadingMenuDelegate
{
    func onRetryClicked(_ view: LoadingMenu)
    {
        loadNewOSTInfos()
    }
}


//MARK:- UITableViewDelegate
extension NewOSTVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        AppUtil.readOSTInfo(self.parent!, dataItems[indexPath.row].ost_link)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return NewOSTCell.cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.1
    }
}


//MARK:- UITableViewDataSource
extension NewOSTVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewOSTCell.className, for: indexPath) as! NewOSTCell
        cell.setModel(dataItems[indexPath.row])
        tableView.addLineForCell(cell: cell, at: indexPath, leftSpace: 0, rightSpace: 0, hasSectionLine: false)
        
        return cell
    }
}
