//
//  HotResourceCell.swift
//  热门资源列表子项
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class HotResourceCell: UITableViewCell
{
    var titleLabel: UILabel!
    var ratingbar: CosmosView!
    var ratingLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: Dimens.fontSizeNormal, textColor: UIColor.darkText)
            titleLabel.textAlignment = .left
            titleLabel.numberOfLines = 2
            contentView.addSubview(titleLabel)
        }
        if ratingbar == nil
        {
            ratingbar = CosmosView()
            ratingbar.settings.totalStars = 5
            ratingbar.settings.starSize = 13
            ratingbar.settings.starMargin = 0
            ratingbar.settings.updateOnTouch = false
            ratingbar.settings.fillMode = .precise
            ratingbar.settings.filledBorderColor = UIColor.red
            ratingbar.settings.filledColor = UIColor.red
            ratingbar.settings.emptyBorderColor = UIColor.lightGray
            ratingbar.settings.emptyColor = UIColor.lightGray
            contentView.addSubview(ratingbar)
        }
        if ratingLabel == nil
        {
            ratingLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: UIColor.red)
            ratingLabel.textAlignment = .right
            contentView.addSubview(ratingLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(32)
        }
        
        ratingbar.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.right.equalTo(ratingLabel.snp.left)
            make.width.equalTo(68)
            make.height.equalTo(14)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingbar)
            make.right.equalTo(titleLabel)
            make.height.equalTo(12)
        }
    }
    
    
    func setModel(_ resource: ResourceInfo)
    {
        titleLabel.text = resource.title
        if resource.rating.isNumber()
        {
            ratingLabel.text = resource.rating
            ratingbar.rating = (resource.rating.toDouble()!) / 2
            ratingbar.isHidden = false
        }
        else
        {
            ratingLabel.text = nil
            ratingbar.isHidden = true
        }
    }
    
    
    static var cellHeight: CGFloat
    {
        return 70
    }
}
