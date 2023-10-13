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
    var starEmptyTipLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: 16, textColor: Colors.link)
            titleLabel.lineBreakMode = .byCharWrapping
            contentView.addSubview(titleLabel)
        }
        if ratingbar == nil
        {
            ratingbar = CosmosView()
            ratingbar.settings.totalStars = 5
            ratingbar.settings.starSize = 13
            ratingbar.settings.starMargin = 0.1
            ratingbar.settings.updateOnTouch = false
            ratingbar.settings.fillMode = .precise
            ratingbar.settings.filledBorderColor = Colors.ratingBar
            ratingbar.settings.filledColor = Colors.ratingBar
            ratingbar.settings.emptyBorderColor = Colors.ratingBarEmpty
            ratingbar.settings.emptyColor = Colors.ratingBarEmpty
            contentView.addSubview(ratingbar)
        }
        if ratingLabel == nil
        {
            ratingLabel = UILabel(fontSize: 12, textColor: Colors._AAA)
            ratingLabel.textAlignment = .right
            contentView.addSubview(ratingLabel)
        }
        if starEmptyTipLabel == nil
        {
            starEmptyTipLabel = UILabel(fontSize: 12, textColor: Colors._AAA)
            starEmptyTipLabel.textAlignment = .right
            starEmptyTipLabel.text = "暂无评分"
            contentView.addSubview(starEmptyTipLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        ratingbar.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.right.equalTo(ratingLabel.snp.left)
            make.width.equalTo(68)
            make.height.equalTo(16)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingbar).offset(-2)
            make.right.equalTo(titleLabel)
            make.height.equalTo(16)
        }
        
        starEmptyTipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingbar)
            make.right.equalTo(titleLabel)
            make.height.equalTo(16)
        }
    }
    
    
    func setModel(_ resource: ResourceInfo)
    {
        titleLabel.text = resource.title
        titleLabel.textColor = !resource.movie_link.isBlank ? Colors._333 : Colors.link
        
        if resource.rating.isNumber()
        {
            starEmptyTipLabel.isHidden = true
            
            ratingLabel.text = resource.rating
            ratingbar.rating = (resource.rating.toDouble()!) / 2
            ratingbar.isHidden = false
        }
        else
        {
            starEmptyTipLabel.isHidden = false
            
            ratingLabel.text = nil
            ratingbar.isHidden = true
        }
    }
    
    
    static var cellHeight: CGFloat
    {
        return 60
    }
}
