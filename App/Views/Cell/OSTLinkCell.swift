//
//  OSTLinkCell.swift
//  "原声大碟"下载链接列表子项
//
//  Created by Sai on 30/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class OSTLinkCell: UITableViewCell
{
    var nameLabel: UILabel!
    var sizeLabel: UILabel!
    

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
            nameLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: Colors.link)
            nameLabel.lineBreakMode = .byCharWrapping
            nameLabel.numberOfLines = 2
            contentView.addSubview(nameLabel)
        }
        if sizeLabel == nil
        {
            sizeLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors.lightWhite)
            sizeLabel.textAlignment = .right
            contentView.addSubview(sizeLabel)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(36)
        }
        
        sizeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.height.equalTo(14)
        }
    }
    
    
    func setModel(_ linkInfo: LinkInfo)
    {
        nameLabel.text = linkInfo.name
        sizeLabel.text = "\(linkInfo.size)"
        
        nameLabel.textColor = !linkInfo.link.isBlank ? Colors.link : Colors._999
        self.accessoryType = !linkInfo.link.isBlank ? .disclosureIndicator : .none
    }
    
    
    static var cellHeight: CGFloat
    {
        return 72
    }
}
