//
//  LinkInfoVC.swift
//  "下载链接"信息视图
//
//  Created by Sai on 16/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class LinkInfoVC: UIViewController
{
    fileprivate var scrollView: UIScrollView!
    fileprivate var contentView: UIView!
    fileprivate var loadingMenu: LoadingMenu!
    
    fileprivate var movieTitleBtn: UIButton!
    fileprivate var linkNameLabel: UILabel!
    fileprivate var linkSizeLabel: UILabel!
    fileprivate var downloadLinkLabel: UILabel!
    fileprivate var copyBtn: UIButton!
    fileprivate var thunderBtn: UIButton!
    
    var linkDetailInfo: LinkDetalInfo!
    var link: String!
    
    
    //MARK:- LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initView()
        loadingMenu.showLoading()
        loadLinkDetailInfo()
    }
    
    
    //MARK:- INIT
    func initView()
    {
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = Colors.viewBg
        title = "下载链接"
        
        scrollView = UIScrollView(frame: Dimens.screenFrameWithoutNavBar)
        view.addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        movieTitleBtn = UIButton(type: .system)
        movieTitleBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: Dimens.fontSizeMiddle)
        movieTitleBtn.setTitleColor(Colors.link, for: .normal)
        movieTitleBtn.contentHorizontalAlignment = .left
        movieTitleBtn.addTarget(self, action: #selector(movieLinkMenuHandler), for: .touchUpInside)
        contentView.addSubview(movieTitleBtn)
        
        linkNameLabel = UILabel(fontSize: Dimens.fontSizeMiddle, textColor: UIColor.black, isBold: true)
        linkNameLabel.lineBreakMode = .byCharWrapping
        linkNameLabel.numberOfLines = 0
        contentView.addSubview(linkNameLabel)
        
        linkSizeLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._AAA)
        linkSizeLabel.numberOfLines = 0
        contentView.addSubview(linkSizeLabel)
        
        let divideLine = UIView(backgroundColor: Colors._BBB)
        contentView.addSubview(divideLine)
        
        downloadLinkLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: Colors.downloadLinkText)
        downloadLinkLabel.lineBreakMode = .byCharWrapping
        downloadLinkLabel.numberOfLines = 0
        contentView.addSubview(downloadLinkLabel)
        
        copyBtn = UIButton(fontSize: 20, textColor: UIColor.white)
        copyBtn.setTitle("复制链接", for: .normal)
        copyBtn.setCornerRadius(radius: 3)
        copyBtn.setBackgroundColor(Colors.buttonNormalBg, forState: .normal)
        copyBtn.setBackgroundColor(Colors.buttonHighlightBg, forState: .highlighted)
        copyBtn.addTarget(self, action: #selector(copyMenuHandler), for: .touchUpInside)
        contentView.addSubview(copyBtn)
        
        thunderBtn = UIButton(fontSize: 20, textColor: UIColor.white)
        thunderBtn.setTitle("迅雷下载", for: .normal)
        thunderBtn.setCornerRadius(radius: 3)
        thunderBtn.setBackgroundColor(Colors.buttonNormalBg, forState: .normal)
        thunderBtn.setBackgroundColor(Colors.buttonHighlightBg, forState: .highlighted)
        thunderBtn.addTarget(self, action: #selector(thunderMenuHandler), for: .touchUpInside)
        contentView.addSubview(thunderBtn)
        
        loadingMenu = LoadingMenu(frame: Dimens.screenFrameWithoutNavBar)
        loadingMenu.delegate = self
        view.addSubview(loadingMenu)
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(ez.screenWidth - 16 * 2)
            make.top.equalToSuperview()
            make.bottom.equalTo(thunderBtn.snp.bottom).offset(50)
        }
        
        movieTitleBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        linkNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(movieTitleBtn.snp.bottom).offset(20)
        }
        
        linkSizeLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(linkNameLabel.snp.bottom).offset(6)
        }
        
        divideLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(linkSizeLabel.snp.bottom).offset(20)
            make.height.equalTo(0.5)
        }
        
        downloadLinkLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(divideLine.snp.bottom).offset(20)
        }
        
        copyBtn.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(downloadLinkLabel.snp.bottom).offset(30)
            make.height.equalTo(44)
        }
        
        thunderBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(copyBtn)
            make.top.equalTo(copyBtn.snp.bottom).offset(16)
        }
    }
    
    
    //MARK: UPDATE
    func updateUI()
    {
        movieTitleBtn.setTitle(linkDetailInfo.movie_title, for: .normal)
        linkNameLabel.text = "\(linkDetailInfo.name)"
        linkSizeLabel.text = "大小: \(linkDetailInfo.size)"
        downloadLinkLabel.text = linkDetailInfo.download_link
        
        if linkDetailInfo.movie_link.isBlank
        {
            movieTitleBtn.snp.remakeConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(0)
            })
        }
    }
    
    
    //MARK:- ACTION
    func loadLinkDetailInfo()
    {
        NetService.getLinkDetailInfo(link: link, onError: { [weak self] (errorCode, errorMsg) in
            
            self?.loadingMenu.showFail()
            
        }, onFailure: { [weak self] (failureMsg) in
                
            self?.loadingMenu.showFail()
            
        }) { [weak self] (data) in
            
            guard let data = data as? LinkDetalInfo else {
                self?.loadingMenu.showEmpty()
                return
            }
            
            self?.loadingMenu.dismiss()
            self?.linkDetailInfo = data
            self?.updateUI()
        }
    }
    
    
    //MARK:- HANDLER
    @objc func movieLinkMenuHandler()
    {
        if !linkDetailInfo.movie_link.isBlank
        {
            AppUtil.readMovieInfo(self, linkDetailInfo.movie_link)
        }
    }
    
    
    @objc func copyMenuHandler()
    {
        UIPasteboard.general.string = linkDetailInfo.download_link
        BannerUtil.showInfo("下载链接已复制到剪贴板")
    }
    
    
    @objc func thunderMenuHandler()
    {
        let link = "AA\(linkDetailInfo.download_link)ZZ".base64  // 根据迅雷的规范生成"迅雷下载"的scheme
        AppUtil.open(scheme: "thunder://\(link)") { (isSuccess) in
            if !isSuccess
            {
                BannerUtil.showInfo("请检查是否已安装了迅雷APP")
            }
        }
    }
}


//MARK:-
extension LinkInfoVC: LoadingMenuDelegate
{
    func onRetryClicked(_ view: LoadingMenu)
    {
        loadLinkDetailInfo()
    }
}
