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
    var directorsLabel: UILabel!
    var writersLabel: UILabel!
    var starsLabel: UILabel!
    var genresLabel: UILabel!
    var countryLabel: UILabel!
    var releaseDateLabel: UILabel!
    var runtimeLabel: UILabel!
    var akanameLabel: UILabel!
    
    var starBg: UIView!
    var starLayout: UIView!
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
            titleLabel.numberOfLines = 0
            contentView.addSubview(titleLabel)
        }
        
        if directorsLabel == nil
        {
            directorsLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            directorsLabel.numberOfLines = 0
            contentView.addSubview(directorsLabel)
        }
        if writersLabel == nil
        {
            writersLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            writersLabel.numberOfLines = 0
            contentView.addSubview(writersLabel)
        }
        if starsLabel == nil
        {
            starsLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            starsLabel.numberOfLines = 0
            contentView.addSubview(starsLabel)
        }
        if genresLabel == nil
        {
            genresLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            genresLabel.numberOfLines = 0
            contentView.addSubview(genresLabel)
        }
        if countryLabel == nil
        {
            countryLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            countryLabel.numberOfLines = 0
            contentView.addSubview(countryLabel)
        }
        if releaseDateLabel == nil
        {
            releaseDateLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            releaseDateLabel.numberOfLines = 0
            contentView.addSubview(releaseDateLabel)
        }
        if runtimeLabel == nil
        {
            runtimeLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            runtimeLabel.numberOfLines = 0
            contentView.addSubview(runtimeLabel)
        }
        if akanameLabel == nil
        {
            akanameLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors._999)
            akanameLabel.numberOfLines = 0
            contentView.addSubview(akanameLabel)
        }
        
        if starBg == nil
        {
            starBg = UIView(backgroundColor: UIColor.white)
            starBg.addShadow(offset: CGSize(width: 2, height: 2), radius: 2, color: Colors._999, opacity: 0.75)
            contentView.addSubview(starBg)
        }
        if starLayout == nil
        {
            starLayout = UIView()
            starBg.addSubview(starLayout)
        }
        if doubanRatingTipLabel == nil
        {
            doubanRatingTipLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors.light)
            doubanRatingTipLabel.textAlignment = .center
            doubanRatingTipLabel.text = "豆瓣评分"
            starLayout.addSubview(doubanRatingTipLabel)
        }
        if starLabel == nil
        {
            starLabel = UILabel(fontSize: 26, textColor: UIColor.black, isBold: true)
            starLabel.textAlignment = .center
            starLayout.addSubview(starLabel)
        }
        if ratingbar == nil
        {
            ratingbar = CosmosView()
            ratingbar.settings.totalStars = 5
            ratingbar.settings.starSize = 13
            ratingbar.settings.starMargin = 0.1
            ratingbar.settings.updateOnTouch = false
            ratingbar.settings.fillMode = .precise
            ratingbar.settings.filledBorderColor = UIColor.red
            ratingbar.settings.filledColor = UIColor.red
            ratingbar.settings.emptyBorderColor = UIColor.lightGray
            ratingbar.settings.emptyColor = UIColor.lightGray
            starLayout.addSubview(ratingbar)
        }
        if starEmptyTipLabel == nil
        {
            starEmptyTipLabel = UILabel(fontSize: Dimens.fontSizeTiny, textColor: Colors.lightDark)
            starEmptyTipLabel.textAlignment = .center
            starEmptyTipLabel.text = "暂无评分"
            starLayout.addSubview(starEmptyTipLabel)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        
        directorsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(starBg.snp.left).offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        writersLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(directorsLabel)
            make.top.equalTo(directorsLabel.snp.bottom).offset(2)
        }
        starsLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(writersLabel)
            make.top.equalTo(writersLabel.snp.bottom).offset(2)
        }
        genresLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(starsLabel)
            make.top.equalTo(starsLabel.snp.bottom).offset(2)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(genresLabel)
            make.top.equalTo(genresLabel.snp.bottom).offset(2)
        }
        releaseDateLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(countryLabel)
            make.top.equalTo(countryLabel.snp.bottom).offset(2)
        }
        runtimeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(releaseDateLabel)
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(2)
        }
        akanameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(runtimeLabel)
            make.top.equalTo(runtimeLabel.snp.bottom).offset(2)
        }
        
        starBg.snp.makeConstraints { (make) in
            make.width.height.equalTo(78)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        starLayout.snp.makeConstraints { (make) in
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
        directorsLabel.text = "导演: \(movieInfo.directors)"
        writersLabel.text = "编剧: \(movieInfo.writers)"
        starsLabel.text = "主演: \(movieInfo.stars)"
        genresLabel.text = "类型: \(movieInfo.genres)"
        countryLabel.text = "国家/地区: \(movieInfo.country)"
        releaseDateLabel.text = "上映日期: \(movieInfo.release_date)"
        runtimeLabel.text = "片长: \(movieInfo.runtime)"
        akanameLabel.text = "又名: \(movieInfo.akaname)"
        
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
    
    
    static var cellHeight: CGFloat
    {
        return 340
    }
}
