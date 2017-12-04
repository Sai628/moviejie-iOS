//
//  OSTInfoVC.swift
//  原声大碟信息视图
//
//  Created by Sai on 30/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class OSTInfoVC: UIViewController
{
    fileprivate var tableView: UITableView!
    fileprivate var loadingMenu: LoadingMenu!
    
    fileprivate var ostInfo: OSTInfo!
    var ostLink: String!
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadingMenu.showLoading()
        loadOSTInfo()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        title = "原声大碟"
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = Colors.viewBg
        tableView.register(MovieBannerCell.self, forCellReuseIdentifier: MovieBannerCell.className)
        tableView.register(OSTBaseInfoCell.self, forCellReuseIdentifier: OSTBaseInfoCell.className)
        tableView.register(OSTSourceCell.self, forCellReuseIdentifier: OSTSourceCell.className)
        tableView.register(OSTTrackListCell.self, forCellReuseIdentifier: OSTTrackListCell.className)
        tableView.register(OSTLinkCell.self, forCellReuseIdentifier: OSTLinkCell.className)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, w: ez.screenWidth, h: CGFloat.leastNormalMagnitude))
        tableView.separatorStyle = .none
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
    
    
    //MARK:- UPDATE
    func updateUI(data: OSTInfo)
    {
        ostInfo = data
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
 
    //MARK:- ACTION
    func loadOSTInfo()
    {
        NetService.getOSTInfo(ostLink: ostLink, onError: { [weak self] (errorCode, errorMsg) in
        
            self?.loadingMenu.showFail()
            
        }, onFailure: { (failureMsg) in
            
            self.loadingMenu.showFail()
            
        }) { [weak self] (data) in
            
            guard let data = data as? OSTInfo else {
                self?.loadingMenu.showEmpty()
                return
            }
            
            self?.loadingMenu.dismiss()
            self?.updateUI(data: data)
        }
    }
}


//MARK:- LoadingMenuDelegate
extension OSTInfoVC: LoadingMenuDelegate
{
    func onRetryClicked(_ view: LoadingMenu)
    {
        loadOSTInfo()
    }
}


extension OSTInfoVC
{
    enum Sections: Int
    {
        case banner
        case info
        case source
        case track
        case link
        case numSections
    }
}


//MARK:- UITableViewDelegate
extension OSTInfoVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section
        {
        case Sections.source.rawValue:
            AppUtil.readMovieInfo(self, ostInfo.movie_link)
        
        case Sections.link.rawValue:
            AppUtil.readLinkInfo(self, ostInfo.links[indexPath.row].link)
        
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case Sections.banner.rawValue:
            return !ostInfo.banner.isBlank ? MovieBannerCell.cellHeight : 0
            
        case Sections.info.rawValue:
            return OSTBaseInfoCell.cellHeightWith(ostInfo: ostInfo)
            
        case Sections.source.rawValue:
            return OSTSourceCell.cellHeight
            
        case Sections.track.rawValue:
            return !ostInfo.track_list.isEmpty ? OSTTrackListCell.cellHeightWith(trackList: ostInfo.track_list) : 0
            
        case Sections.link.rawValue:
            return OSTLinkCell.cellHeight
            
        default:
            fatalError("indexPath invalid:\(indexPath)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let sectionType = Sections(rawValue: section)!
        if sectionType == .source && !ostInfo.movie_name.isBlank ||
            sectionType == .track && !ostInfo.track_list.isEmpty ||
            sectionType == .link && ostInfo.links.count > 0
        {
            return 28
        }
        
        return CGFloat.leastNormalMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return CGFloat.leastNormalMagnitude
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let type = Sections(rawValue: section)!
        guard [Sections.source, Sections.track, Sections.link].contains(type) else {
            return nil
        }
        
        if type == .source && ostInfo.movie_name.isBlank ||
            type == .track && ostInfo.track_list.isEmpty ||
            type == .link && ostInfo.links.count == 0
        {
            return nil
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.w, height: 28))
        headerView.backgroundColor = Colors.tableViewHeaderBg
        
        let label = UILabel(fontSize: 16, textColor: Colors.tableViewHeaderTitle, isBold: true)
        label.frame = CGRect(x: 16, y: 6, width: tableView.w - 16, height: 18)
        label.textAlignment = .left
        label.text = ["", "", "来源电影/电视剧", "专辑曲目", "下载链接"][section]
        headerView.addSubview(label)

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
}


//MARK:- UITableViewDataSource
extension OSTInfoVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return Sections.numSections.rawValue
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case Sections.banner.rawValue,
             Sections.info.rawValue:
            return 1
            
        case Sections.source.rawValue:
            return ostInfo.movie_name.isBlank ? 0 : 1
            
        case Sections.track.rawValue:
            return ostInfo.track_list.isEmpty ? 0 : 1
            
        case Sections.link.rawValue:
            return ostInfo.links.count
        
        default:
            fatalError("section invalid:\(section)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell!
        switch indexPath.section
        {
        case Sections.banner.rawValue:
            cell = getBannerCell(tableView, cellForRowAt: indexPath)
            
        case Sections.info.rawValue:
            cell = getBaseInfoCell(tableView, cellForRowAt: indexPath)
            
        case Sections.source.rawValue:
            cell = getSourceCell(tableView, cellForRowAt: indexPath)
            
        case Sections.track.rawValue:
            cell = getTrackCell(tableView, cellForRowAt: indexPath)
            
        case Sections.link.rawValue:
            cell = getLinkCell(tableView, cellForRowAt: indexPath)
            
        default:
            fatalError("indexPath invalid:\(indexPath)")
        }
        
        tableView.addLineForCell(cell: cell, at: indexPath, leftSpace: 0, rightSpace: 0, hasSectionLine: true)
        return cell
    }
    
    
    func getBannerCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieBannerCell.className, for: indexPath) as! MovieBannerCell
        cell.setModel(ostInfo.banner)
        return cell
    }
    
    
    func getBaseInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: OSTBaseInfoCell.className, for: indexPath) as! OSTBaseInfoCell
        cell.setModel(ostInfo)
        return cell
    }
    
    
    func getSourceCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: OSTSourceCell.className, for: indexPath) as! OSTSourceCell
        cell.setModel(ostInfo.movie_name)
        return cell
    }
    
    
    func getTrackCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: OSTTrackListCell.className, for: indexPath) as! OSTTrackListCell
        cell.setModel(ostInfo.track_list)
        return cell
    }
    
    
    func getLinkCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: OSTLinkCell.className, for: indexPath) as! OSTLinkCell
        cell.setModel(ostInfo.links[indexPath.row])
        return cell
    }
}
