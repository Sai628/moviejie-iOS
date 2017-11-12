//
//  SearchVC.swift
//  "搜索"视图
//
//  Created by Sai on 07/11/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class SearchVC: UIViewController
{
    fileprivate var searchLayout: UIView!
    fileprivate var searchIconIv: UIImageView!
    fileprivate var searchTextField: UITextField!
    fileprivate var cancelBtn: UIButton!
    fileprivate var tableView: UITableView!
    
    fileprivate var searchHistoryDataItems: [String] = []
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        navBar?.isHidden = true
        app_autoToolbarDisabled()
        
        tableView.reloadData()
        searchTextField.becomeFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        navBar?.isHidden = false
        app_autoToolbarEnable()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        title = "搜索"
        
        let navBarLayout = UIView(backgroundColor: UIColor.white)
        navBarLayout.addBorder(width: 0.5, color: Colors._DDD)
        view.addSubview(navBarLayout)
        
        searchLayout = UIView(backgroundColor: Colors._EEE)
        searchLayout.setCornerRadius(radius: 15)
        navBarLayout.addSubview(searchLayout)
        
        searchIconIv = UIImageView(image: UIImage(named: R.icon_search_normal))
        searchLayout.addSubview(searchIconIv)
        
        searchTextField = UITextField(fontSize: 14, textColor: Colors._333)
        searchTextField.placeholder = "搜索电影"
        searchTextField.keyboardType = .default
        searchTextField.textAlignment = .left
        searchTextField.returnKeyType = .search
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.autocorrectionType = .no
        searchTextField.autocapitalizationType = .none
        searchTextField.delegate = self
        searchLayout.addSubview(searchTextField)
        
        cancelBtn = UIButton(fontSize: 16, textColor: Colors._AAA)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(doCancel), for: .touchUpInside)
        navBarLayout.addSubview(cancelBtn)
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.register(SearchHistoryCell.self, forCellReuseIdentifier: SearchHistoryCell.className)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        navBarLayout.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-0.5)
            make.left.equalToSuperview().offset(-0.5)
            make.right.equalToSuperview().offset(0.5)
            make.height.equalTo(64.5)
        }
        
        searchLayout.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(27)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        searchIconIv.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13.5)
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { (make) in
            make.left.equalTo(searchIconIv.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(28)
            make.centerY.equalToSuperview()
        }
        
        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(searchLayout.snp.right).offset(11)
            make.width.equalTo(34)
            make.height.equalTo(22)
            make.centerY.equalTo(searchLayout)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBarLayout.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
    func loadData()
    {
        searchHistoryDataItems = AppUserData.getSearchHistory()
        tableView.reloadData()
    }
    
    
    //MARK:- HANDLER
    func doCancel()
    {
        popVC()
    }
    
    
    func doSearch(_ keyword: String)
    {
        dismissKeyboard()
        
        searchHistoryDataItems.removeFirst(keyword)
        searchHistoryDataItems.insertFirst(keyword)
        AppUserData.saveSearchHistory(searchHistoryDataItems)
        
        let searchResultVC = SearchResultVC()
        searchResultVC.keyword = keyword
        pushVC(searchResultVC)
    }
    
    
    func clearAllSearchHistory()
    {
        dismissKeyboard()
        
        EZAlertController.alert("提示", message: "是否清空所有搜索历史?", buttons: ["取消", "清空"]) { [unowned self] (action, index) in
            
            guard index == 1 else {
                return
            }
            
            self.searchHistoryDataItems = []
            AppUserData.saveSearchHistory(self.searchHistoryDataItems)
            
            self.tableView.reloadData()
        }
    }
    
    
    func searchHistoryRemoveMenuHandler(row: Int)
    {
        searchHistoryDataItems.remove(at: row)
        AppUserData.saveSearchHistory(searchHistoryDataItems)
        
        tableView.reloadData()
    }
}


//MARK:- UITextFieldDelegate
extension SearchVC: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        guard textField.returnKeyType == .search, let keyword = textField.text, !keyword.isBlank else {
            return false
        }

        doSearch(keyword)
        return true
    }
}


//MARK:- UITableViewDelegate
extension SearchVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        doSearch(searchHistoryDataItems[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return SearchHistoryCell.cellHeight
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        guard searchHistoryDataItems.count > 0 else {
            return nil
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.w, height: 40))
        
        let tipSearchTipLabel = UILabel(fontSize: 14, textColor: UIColor.black, isBold: true)
        tipSearchTipLabel.textAlignment = .left
        tipSearchTipLabel.text = "搜索历史"
        headerView.addSubview(tipSearchTipLabel)
        
        let clearBtn = UIButton(type: .custom)
        clearBtn.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 0)
        clearBtn.setImage(UIImage(named: R.icon_clearup_normal), for: .normal)
        clearBtn.setImage(UIImage(named: R.icon_clearup_highlight), for: .highlighted)
        clearBtn.addTarget(self, action: #selector(clearAllSearchHistory), for: .touchUpInside)
        headerView.addSubview(clearBtn)
        
        tipSearchTipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        
        clearBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalToSuperview()
        }
        
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
}


//MARK:- UITableViewDataSource
extension SearchVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return searchHistoryDataItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryCell.className, for: indexPath) as! SearchHistoryCell
        let title = searchHistoryDataItems[indexPath.row]
        cell.setModel(title: title)
        cell.removeMenuHandler = { [weak self] in
            self?.searchHistoryRemoveMenuHandler(row: indexPath.row)
        }
        
        tableView.addLineForCell(cell: cell, at: indexPath, leftSpace: 16, rightSpace: 16, hasSectionLine: true, color: Colors._EEE)
        return cell
    }
}
