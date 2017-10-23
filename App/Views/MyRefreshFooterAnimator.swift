//
//  MyRefreshFooterAnimator.swift
//  自定义加载更多底部控件
//
//  Created by Sai on 23/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import ESPullToRefresh
import EZSwiftExtensions
import SnapKit


class MyRefreshFooterAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol
{
    public let loadingMoreDescription: String = "正在加载更多"
    public let noMoreDataDescription: String  = "没有更多了"
    public let loadingDescription: String     = "正在加载更多"
    
    public var view: UIView {
        return self
    }
    
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var trigger: CGFloat = 68.0
    public var executeIncremental: CGFloat = 68.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private let titleLabel: UILabel =
    {
        let label = UILabel(fontSize: 14, textColor: Colors._AAA)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView =
    {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    
    public required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        titleLabel.text = loadingMoreDescription
        
        let contetView = UIView()
        contetView.addSubview(indicatorView)
        contetView.addSubview(titleLabel)
        addSubview(contetView)
        
        contetView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(114)
            make.height.equalTo(20)
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(indicatorView.snp.right).offset(8)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    
    public func refreshAnimationBegin(view: ESRefreshComponent)
    {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        titleLabel.isHidden = false
    }
    
    
    public func refreshAnimationEnd(view: ESRefreshComponent)
    {
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
        titleLabel.isHidden = true
    }
    
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat)
    {
        // do nothing
    }
    
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState)
    {
        switch state
        {
        case .refreshing :
            titleLabel.text = loadingDescription
        
        case .autoRefreshing :
            titleLabel.text = loadingDescription
        
        case .noMoreData:
            titleLabel.text = noMoreDataDescription
        
        default:
            titleLabel.text = loadingMoreDescription
        }
    }
}
