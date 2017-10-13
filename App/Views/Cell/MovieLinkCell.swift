//
//  MovieLinkCell.swift
//  "电影/电视剧"下载链接列表子项
//
//  Created by Sai on 13/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MovieLinkCell: UITableViewCell
{
    var nameLabel: UILabel!
    var otherInfoLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        if nameLabel == nil
        {
            nameLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: UIColor.darkText)
            nameLabel.lineBreakMode = .byCharWrapping
            nameLabel.numberOfLines = 2
            contentView.addSubview(nameLabel)
        }
        if otherInfoLabel == nil
        {
            otherInfoLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: UIColor.lightGray)
            otherInfoLabel.textAlignment = .right
            contentView.addSubview(otherInfoLabel)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(36)
        }
        
        otherInfoLabel.snp.makeConstraints { (make) in
            make.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.height.equalTo(14)
        }
    }
    
    
    func setModel(_ linkInfo: LinkInfo)
    {
        nameLabel.text = linkInfo.name
        otherInfoLabel.text = "\(linkInfo.size)/\(linkInfo.dimen)/\(linkInfo.format)"
    }
    
    
    static var cellHeight: CGFloat
    {
        return 72
    }
}
