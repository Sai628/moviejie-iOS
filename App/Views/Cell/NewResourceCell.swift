//
//  NewResourceCell.swift
//  最新资源列表子项
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class NewResourceCell: UITableViewCell
{
    var titleLabel: UILabel!
    var sizeLabel: UILabel!
    
    
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
            titleLabel = UILabel(fontSize: Dimens.fontSizeNormal, textColor: Colors.link)
            titleLabel.lineBreakMode = .byCharWrapping
            titleLabel.numberOfLines = 2
            contentView.addSubview(titleLabel)
        }
        if sizeLabel == nil
        {
            sizeLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors.lightWhite)
            sizeLabel.textAlignment = .right
            contentView.addSubview(sizeLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        sizeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.height.equalTo(12)
        }
    }
    
    
    func setModel(_ resource: ResourceInfo)
    {
        titleLabel.text = resource.title
        sizeLabel.text = resource.size
        
        titleLabel.textColor = !resource.movie_link.isBlank ? Colors._333 : Colors.link
    }
    
    
    static var cellHeight: CGFloat
    {
        return 74
    }
}
