//
//  OSTSourceCell.swift
//  "原声大碟"来源的电影剧/电影列表子项
//
//  Created by Sai on 30/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class OSTSourceCell: UITableViewCell
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
            titleLabel = UILabel(fontSize: Dimens.fontSizeMiddle, textColor: Colors.link)
            titleLabel.lineBreakMode = .byWordWrapping
            contentView.addSubview(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    
    func setModel(_ title: String)
    {
        titleLabel.text = title
    }
    
    
    static var cellHeight: CGFloat
    {
        return 52
    }
}
