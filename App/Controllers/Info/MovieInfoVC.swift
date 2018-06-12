//
//  MovieInfoVC.swift
//  "电影/电视剧"信息视图
//
//  Created by Sai on 13/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MovieInfoVC: UIViewController
{
    fileprivate var tableView: UITableView!
    fileprivate var loadingMenu: LoadingMenu!
    
    fileprivate var movieInfo: MovieInfo!
    fileprivate var episodeLinks: [LinkInfo] = []
    fileprivate var currentEpisode: String = ""  // 当前分集(默认为空, 表示显示全部的分集)
    fileprivate var currentEpisodeText: String = ""  // 当前分集提示文字
    var movieLink: String!
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadingMenu.showLoading()
        loadMovieInfo()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        title = "电影/电视剧"
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = Colors.viewBg
        tableView.register(MovieBannerCell.self, forCellReuseIdentifier: MovieBannerCell.className)
        tableView.register(MovieBaseInfoCell.self, forCellReuseIdentifier: MovieBaseInfoCell.className)
        tableView.register(MovieLinkCell.self, forCellReuseIdentifier: MovieLinkCell.className)
        tableView.register(MovieRelatedInfoCell.self, forCellReuseIdentifier: MovieRelatedInfoCell.className)
        tableView.register(MovieStoryCell.self, forCellReuseIdentifier: MovieStoryCell.className)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, w: ez.screenWidth, h: CGFloat.leastNormalMagnitude))
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        loadingMenu = LoadingMenu(frame: Dimens.screenFrameWithoutNavBar)
        loadingMenu.delegate = self
        view.addSubview(loadingMenu)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Dimens.navBarHeight)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Dimens.safeAreaBottom)
        }
    }
    
    
    //MARK:- UPDATE
    func updateUI(data: MovieInfo)
    {
        movieInfo = data
        episodeLinks = movieInfo.links
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        if movieInfo.episode_filters.count > 0
        {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "选集", style: .plain,
                                                                target: self, action: #selector(doEpisodeFilter))
        }
    }
    
 
    //MARK:- ACTION
    func loadMovieInfo()
    {
        NetService.getMovieInfo(movieLink: movieLink, onError: { [weak self] (errorCode, errorMsg) in
        
            self?.loadingMenu.showFail()
            
        }, onFailure: { (failureMsg) in
            
            self.loadingMenu.showFail()
            
        }) { [weak self] (data) in
            
            guard let data = data as? MovieInfo else {
                self?.loadingMenu.showEmpty()
                return
            }
            
            self?.loadingMenu.dismiss()
            self?.updateUI(data: data)
        }
    }
    
    
    //MARK:- HANDLER
    @objc func doEpisodeFilter()
    {
        let episodeFilterVC = EpisodeFilterVC()
        episodeFilterVC.episodeFitlers = movieInfo.episode_filters
        episodeFilterVC.delegate = self
        episodeFilterVC.selectedEpisode = currentEpisode
        pushVC(episodeFilterVC)
    }
}


//MARK:- LoadingMenuDelegate
extension MovieInfoVC: LoadingMenuDelegate
{
    func onRetryClicked(_ view: LoadingMenu)
    {
        loadMovieInfo()
    }
}


//MARK:- EpisodeFilterDelegate
extension MovieInfoVC: EpisodeFilterDelegate
{
    func onItemClicked(index: Int, episode: String, text: String)
    {
        episodeLinks = (episode == "all" ? movieInfo.links : movieInfo.links.filter{ $0.episode == episode })
        currentEpisode = episode
        currentEpisodeText = text
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: Sections.link.rawValue), at: .top, animated: true)
    }
}


extension MovieInfoVC
{
    enum Sections: Int
    {
        case banner
        case info
        case link
        case related
        case recommended
        case story
        case numSections
    }
}


//MARK:- UITableViewDelegate
extension MovieInfoVC: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section
        {
        case Sections.link.rawValue:
            let link = episodeLinks[indexPath.row].link
            if !link.isBlank {
                AppUtil.readLinkInfo(self, link)
            }
            break
        
        case Sections.related.rawValue:
            AppUtil.readMovieInfo(self, movieInfo.related_resources[indexPath.row].movie_link)
            
        case Sections.recommended.rawValue:
            AppUtil.readMovieInfo(self, movieInfo.recommended_resources[indexPath.row].movie_link)
            
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section
        {
        case Sections.banner.rawValue:
            return !movieInfo.banner.isBlank ? MovieBannerCell.cellHeight : 0
            
        case Sections.info.rawValue:
            return MovieBaseInfoCell.cellHeightWith(movieInfo: movieInfo)
            
        case Sections.link.rawValue:
            return MovieLinkCell.cellHeight
            
        case Sections.related.rawValue, Sections.recommended.rawValue:
            return MovieRelatedInfoCell.cellHeight
            
        case Sections.story.rawValue:
            return !movieInfo.story.isBlank ? MovieStoryCell.cellHeightWith(story: movieInfo.story) : 0
            
        default:
            fatalError("indexPath invalid:\(indexPath)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        let sectionType = Sections(rawValue: section)!
        if sectionType == .link && episodeLinks.count > 0 ||
            sectionType == .related && movieInfo.related_resources.count > 0 ||
            sectionType == .recommended && movieInfo.recommended_resources.count > 0 ||
            sectionType == .story && !movieInfo.story.isBlank
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
        guard [Sections.link, Sections.related, Sections.recommended, Sections.story].contains(type) else {
            return nil
        }
        
        if type == .link && episodeLinks.count == 0 ||
            type == .related && movieInfo.related_resources.count == 0 ||
            type == .recommended && movieInfo.recommended_resources.count == 0 ||
            type == .story && movieInfo.story.isBlank
        {
            return nil
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.w, height: 28))
        headerView.backgroundColor = Colors.tableViewHeaderBg
        
        let label = UILabel(fontSize: 16, textColor: Colors.tableViewHeaderTitle, isBold: true)
        label.frame = CGRect(x: 16, y: 6, width: tableView.w - 16, height: 18)
        label.textAlignment = .left
        label.text = ["", "", "下载链接 \(currentEpisodeText)", "相关影视", "猜你喜欢", "剧情简介"][section]
        headerView.addSubview(label)

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return nil
    }
}


//MARK:- UITableViewDataSource
extension MovieInfoVC: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return Sections.numSections.rawValue
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case Sections.banner.rawValue:
            return 1
            
        case Sections.info.rawValue:
            return 1
            
        case Sections.link.rawValue:
            return episodeLinks.count
        
        case Sections.related.rawValue:
            return movieInfo.related_resources.count
        
        case Sections.recommended.rawValue:
            return movieInfo.recommended_resources.count
        
        case Sections.story.rawValue:
            return 1
        
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
            
        case Sections.link.rawValue:
            cell = getLinkCell(tableView, cellForRowAt: indexPath)
            
        case Sections.related.rawValue:
            cell = getRelatedCell(tableView, cellForRowAt: indexPath, resourceInfo: movieInfo.related_resources[indexPath.row])
            
        case Sections.recommended.rawValue:
            cell = getRelatedCell(tableView, cellForRowAt: indexPath, resourceInfo: movieInfo.recommended_resources[indexPath.row])
            
        case Sections.story.rawValue:
            cell = getStoryCell(tableView, cellForRowAt: indexPath)
            
        default:
            fatalError("indexPath invalid:\(indexPath)")
        }
        
        tableView.addLineForCell(cell: cell, at: indexPath, leftSpace: 0, rightSpace: 0, hasSectionLine: true)
        return cell
    }
    
    
    func getBannerCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieBannerCell.className, for: indexPath) as! MovieBannerCell
        cell.setModel(movieInfo.banner)
        return cell
    }
    
    
    func getBaseInfoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieBaseInfoCell.className, for: indexPath) as! MovieBaseInfoCell
        cell.setModel(movieInfo)
        return cell
    }
    
    
    func getLinkCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieLinkCell.className, for: indexPath) as! MovieLinkCell
        cell.setModel(episodeLinks[indexPath.row])
        return cell
    }
    
    
    func getRelatedCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, resourceInfo: ResourceInfo) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieRelatedInfoCell.className, for: indexPath) as! MovieRelatedInfoCell
        cell.setModel(resourceInfo)
        return cell
    }
    
    
    func getStoryCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieStoryCell.className, for: indexPath) as! MovieStoryCell
        cell.setModel(movieInfo.story)
        return cell
    }
}
