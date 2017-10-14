//
//  MovieRelInfoCell.swift
//  "电影/电视剧"相关影视/猜你喜欢列表子项
//
//  Created by Sai on 13/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MovieRelatedInfoCell: UITableViewCell
{
    var titleLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: Colors.link)
            titleLabel.lineBreakMode = .byWordWrapping
            contentView.addSubview(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    
    func setModel(_ resourceInfo: ResourceInfo)
    {
        titleLabel.text = resourceInfo.title
    }
    
    
    static var cellHeight: CGFloat
    {
        return 44
    }
}
