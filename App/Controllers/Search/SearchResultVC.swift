//
//  SearchResultVC.swift
//  "搜索结果"视图
//
//  Created by Sai on 07/11/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class SearchResultVC: UIViewController
{
    fileprivate var tableView: UITableView!
    fileprivate var loadingMenu: LoadingMenu!
    
    fileprivate var dataItems: [MovieSimpleInfo] = []
    fileprivate var currentPage: Int = 1
    
    var keyword: String!  // 搜索关键词. 跳转到该视图时需设置该参数
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadingMenu.showLoading()
        loadSearchResult()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        title = "搜索\"\(keyword!)\""
        
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.register(NewMovieCell.self, forCellReuseIdentifier: NewMovieCell.className)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        let refreshFooter = MyRefreshFooterAnimator(frame: CGRect(x: 0, y: 0, w: ez.screenWidth, h: 68))
        tableView.es.addInfiniteScrolling(animator: refreshFooter) { [weak self] in
            self?.loadMoreSearchResult()
        }
        view.addSubview(tableView)
        
        loadingMenu = LoadingMenu(frame: Dimens.screenFrameWithoutNavBar)
        loadingMenu.delegate = self
        view.addSubview(loadingMenu)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimens.navBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    //MARK:- ACTION
    func loadSearchResult()
    {
        NetService.search(keyword: keyword, page: "p1", onError: { [weak self] (errorCode, errroMsg) in
            
            self?.loadingMenu.showFail()
            
        }, onFailure: { [weak self] (failureMsg) in
            
            self?.loadingMenu.showFail()
            
        }) { [weak self] (data) in
            
            self?.loadingMenu.dismiss()
            guard let movies = data as? [MovieSimpleInfo], movies.count > 0 else {
                self?.loadingMenu.showEmpty()
                return
            }
            
            self?.currentPage = 2
            self?.dataItems = movies
            self?.tableView.reloadData()
        }
    }
    
    
    func loadMoreSearchResult()
    {
        NetService.search(keyword: keyword, page: "p\(currentPage)", onError: { [weak self] (errorCode, errorMsg) in
            
            self?.tableView.es.stopLoadingMore()
            
        }, onFailure: { [weak self] (failureMsg) in
            
            self?.tableView.es.stopLoadingMore()
            
        }) { [weak self] (data) in
            
            let movies = data as! [MovieSimpleInfo]
            self?.dataItems.append(contentsOf: movies)
            self?.tableView.reloadData()
            
            guard movies.count >= 10 else {
                self?.tableView.es.stopLoadingMore()
                return
            }
            
            self?.tableView.es.stopLoadingMore()
            self?.currentPage += 1
        }
    }
}


//MARK:- LoadingMenuDelegate
extension SearchResultVC: LoadingMenuDelegate
{
    func onRetryClicked(_ view: LoadingMenu)
    {
        loadSearchResult()
    }
}


//MARK:- UITableViewDelegate
extension SearchResultVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        AppUtil.readMovieInfo(self, dataItems[indexPath.row].movie_link)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return NewMovieCell.cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 0.1
    }
}


//MARK:- UITableViewDataSource
extension SearchResultVC: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewMovieCell.className, for: indexPath) as! NewMovieCell
        cell.setModel(dataItems[indexPath.row])
        tableView.addLineForCell(cell: cell, at: indexPath, leftSpace: 0, rightSpace: 0, hasSectionLine: false)
        
        return cell
    }
}
