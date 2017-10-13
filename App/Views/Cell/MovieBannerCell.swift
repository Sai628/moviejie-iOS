//
//  MovieBannerCell.swift
//  "电影/电视剧"封面图列表子项
//
//  Created by Sai on 14/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MovieBannerCell: UITableViewCell
{
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
        
        if bannerIv == nil
        {
            bannerIv = UIImageView()
            bannerIv.contentMode = .scaleAspectFit
            backgroundColor = UIColor.random()
            contentView.addSubview(bannerIv)
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
        bannerIv.app_setImage(with: bannerURL)
    }
    
    
    static var cellHeight: CGFloat
    {
        return 220
    }
}
