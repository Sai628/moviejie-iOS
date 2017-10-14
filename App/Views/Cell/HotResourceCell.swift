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
    var movieMarkLine: UIView!
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
        self.accessoryType = .disclosureIndicator
        
        if movieMarkLine == nil
        {
            movieMarkLine = UIView(backgroundColor: Colors.movieMarkLine)
            contentView.addSubview(movieMarkLine)
        }
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: Dimens.fontSizeNormal, textColor: Colors.link)
            titleLabel.lineBreakMode = .byCharWrapping
            contentView.addSubview(titleLabel)
        }
        if ratingbar == nil
        {
            ratingbar = CosmosView()
            ratingbar.settings.totalStars = 5
            ratingbar.settings.starSize = 13
            ratingbar.settings.starMargin = -2
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
            ratingLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: UIColor.red)
            ratingLabel.textAlignment = .right
            contentView.addSubview(ratingLabel)
        }
        
        movieMarkLine.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(5)
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
            make.width.equalTo(58)
            make.height.equalTo(14)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(ratingbar).offset(-1)
            make.right.equalTo(titleLabel)
            make.height.equalTo(14)
        }
    }
    
    
    func setModel(_ resource: ResourceInfo)
    {
        movieMarkLine.isHidden = resource.movie_link.isBlank
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
        return 60
    }
}
