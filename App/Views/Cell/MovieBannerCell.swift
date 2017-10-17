//
//  MovieBannerCell.swift
//  "电影/电视剧"封面图列表子项
//
//  Created by Sai on 14/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import Kingfisher
import SnapKit


class MovieBannerCell: UITableViewCell
{
    fileprivate var bgIv: UIImageView!
    fileprivate var bannerIv: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if bgIv == nil
        {
            bgIv = UIImageView()
            bgIv.backgroundColor = UIColor(gray: 0, alpha: 0.75)
            bgIv.contentMode = .scaleAspectFill
            bgIv.clipsToBounds = true
            contentView.addSubview(bgIv)
        }
        if bannerIv == nil
        {
            bannerIv = UIImageView()
            bannerIv.contentMode = .scaleAspectFit
            contentView.addSubview(bannerIv)
        }
        
        bgIv.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        bannerIv.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    
    func setModel(_ bannerURL: String)
    {
        bgIv.app_setImage(with: bannerURL, options: [.processor(BlurImageProcessor(blurRadius: 10) >> OverlayImageProcessor(overlay: .black, fraction: 0.3))])
        bannerIv.app_setImage(with: bannerURL, options: [.transition(ImageTransition.fade(0.2))])
    }
    
    
    static var cellHeight: CGFloat
    {
        return 300
    }
}
