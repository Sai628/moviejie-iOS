//
//  MovieBaseInfoCell.swift
//  "电影/电视剧"基本信息列表子项
//
//  Created by Sai on 13/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MovieBaseInfoCell: UITableViewCell
{
    var titleLabel: UILabel!
    var baseInfoLabel: UILabel!
    
    var starBg: UIView!
    var starContentView: UIView!
    var doubanRatingTipLabel: UILabel!
    var starLabel: UILabel!
    var ratingbar: CosmosView!
    var starEmptyTipLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: 26, textColor: UIColor.black, isBold: true)
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.numberOfLines = 0
            contentView.addSubview(titleLabel)
        }
        if baseInfoLabel == nil
        {
            baseInfoLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._AAA)
            baseInfoLabel.lineBreakMode = .byWordWrapping
            baseInfoLabel.numberOfLines = 0
            contentView.addSubview(baseInfoLabel)
        }
        
        if starBg == nil
        {
            starBg = UIView(backgroundColor: UIColor.white)
            starBg.addShadow(offset: CGSize(width: 2, height: 2), radius: 2, color: Colors._AAA, opacity: 0.75)
            contentView.addSubview(starBg)
        }
        if starContentView == nil
        {
            starContentView = UIView()
            starBg.addSubview(starContentView)
        }
        if doubanRatingTipLabel == nil
        {
            doubanRatingTipLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors.lightWhite)
            doubanRatingTipLabel.textAlignment = .center
            doubanRatingTipLabel.text = "豆瓣评分"
            starContentView.addSubview(doubanRatingTipLabel)
        }
        if starLabel == nil
        {
            starLabel = UILabel(fontSize: 26, textColor: UIColor.black, isBold: true)
            starLabel.textAlignment = .center
            starContentView.addSubview(starLabel)
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
            starContentView.addSubview(ratingbar)
        }
        if starEmptyTipLabel == nil
        {
            starEmptyTipLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors.lightDark)
            starEmptyTipLabel.textAlignment = .center
            starEmptyTipLabel.text = "暂无评分"
            starContentView.addSubview(starEmptyTipLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        
        baseInfoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(starBg.snp.left).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        
        starBg.snp.makeConstraints { (make) in
            make.width.height.equalTo(78)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        starContentView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
            make.top.equalTo(doubanRatingTipLabel)
            make.bottom.equalTo(starEmptyTipLabel)
        }
        doubanRatingTipLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(14)
        }
        starLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(doubanRatingTipLabel.snp.bottom).offset(2)
            make.height.equalTo(30)
        }
        ratingbar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(starLabel.snp.bottom).offset(2)
            make.height.equalTo(16)
        }
        starEmptyTipLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(ratingbar.snp.bottom).offset(2)
            make.height.equalTo(14)
        }
    }
    
    
    func setModel(_ movieInfo: MovieInfo)
    {
        titleLabel.text = movieInfo.title
        baseInfoLabel.text = MovieBaseInfoCell.getBaseInfoText(movieInfo: movieInfo)
 
        if movieInfo.star.isNumber()
        {
            starLabel.text = movieInfo.star
            ratingbar.rating = (movieInfo.star.toDouble()!) / 2
            
            starLabel.snp.updateConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(doubanRatingTipLabel.snp.bottom)
                make.height.equalTo(30)
            })
            starEmptyTipLabel.snp.updateConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(ratingbar.snp.bottom)
                make.height.equalTo(0)
            })
        }
        else
        {
            starLabel.text = nil
            ratingbar.rating = 0
            
            starLabel.snp.updateConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(doubanRatingTipLabel.snp.bottom).offset(2)
                make.height.equalTo(0)
            })
            starEmptyTipLabel.snp.updateConstraints({ (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(ratingbar.snp.bottom).offset(2)
                make.height.equalTo(14)
            })
        }
    }
    
    
    private static func getBaseInfoText(movieInfo: MovieInfo) -> String
    {
        var baseInfoText = ""
        baseInfoText += !movieInfo.directors.isBlank ? "导演: \(movieInfo.directors)\n" : ""
        baseInfoText += !movieInfo.writers.isBlank ? "编剧: \(movieInfo.writers)\n" : ""
        baseInfoText += !movieInfo.stars.isBlank ? "主演: \(movieInfo.stars)\n" : ""
        baseInfoText += !movieInfo.genres.isBlank ? "类型: \(movieInfo.genres)\n" : ""
        baseInfoText += !movieInfo.country.isBlank ? "国家/地区: \(movieInfo.country)\n" : ""
        baseInfoText += !movieInfo.release_date.isBlank ? "上映日期: \(movieInfo.release_date)\n" : ""
        baseInfoText += !movieInfo.runtime.isBlank ? "片长: \(movieInfo.runtime)\n" : ""
        baseInfoText += !movieInfo.akaname.isBlank ? "又名: \(movieInfo.akaname)" : ""
        
        return baseInfoText
    }
    
    
    static func cellHeightWith(movieInfo: MovieInfo) -> CGFloat
    {
        let titleLabelWidth = ez.screenWidth - 20 * 2
        let baseInfoLabelWidth = ez.screenWidth - 20 * 2 - 78 - 20
        let baseInfoText = getBaseInfoText(movieInfo: movieInfo)
        
        let titleLabelHeight = movieInfo.title.height(titleLabelWidth, font: UIFont.systemFont(ofSize: 26), lineBreakMode: .byWordWrapping)
        let baseInfoLabelHeight = baseInfoText.height(baseInfoLabelWidth, font: UIFont.systemFont(ofSize: Dimens.fontSizeTiny),
                                      lineBreakMode: .byWordWrapping)
        
        return 20 + titleLabelHeight + 16 + max(baseInfoLabelHeight, 100) + 30
    }
}
