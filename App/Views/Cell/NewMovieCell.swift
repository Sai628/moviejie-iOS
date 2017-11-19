//
//  NewMovieCell.swift
//  最新电影列表子项
//
//  Created by Sai on 23/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import Kingfisher
import SnapKit


class NewMovieCell: UITableViewCell
{
    fileprivate var bannerIv: UIImageView!
    fileprivate var titleLabel: UILabel!
    fileprivate var ratingbar: CosmosView!
    fileprivate var ratingLabel: UILabel!
    fileprivate var starEmptyTipLabel: UILabel!
    fileprivate var genresLabel: UILabel!
    fileprivate var countryLabel: UILabel!
    
    fileprivate var bannerPlaceHolder: UIImage!
    static let bannerImageHeight: CGFloat = 110
    static let bannerImageWidth: CGFloat = bannerImageHeight * 0.72

    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        if bannerPlaceHolder == nil
        {
            bannerPlaceHolder = ImageUtil.create(withColor: Colors._EEE, andSize: CGSize(width: NewMovieCell.bannerImageWidth,
                                                                                         height: NewMovieCell.bannerImageHeight))
        }
        if bannerIv == nil
        {
            bannerIv = UIImageView()
            contentView.addSubview(bannerIv)
        }
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: 17, textColor: Colors._333, isBold: true)
            titleLabel.lineBreakMode = .byCharWrapping
            titleLabel.numberOfLines = 2
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
            contentView.addSubview(ratingLabel)
        }
        if starEmptyTipLabel == nil
        {
            starEmptyTipLabel = UILabel(fontSize: 12, textColor: Colors.lightWhite)
            starEmptyTipLabel.text = "暂无评分"
            contentView.addSubview(starEmptyTipLabel)
        }
        if genresLabel == nil
        {
            genresLabel = UILabel(fontSize: 12, textColor: Colors._AAA)
            contentView.addSubview(genresLabel)
        }
        if countryLabel == nil
        {
            countryLabel = UILabel(fontSize: 12, textColor: Colors._AAA)
            contentView.addSubview(countryLabel)
        }
        
        bannerIv.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(NewMovieCell.bannerImageWidth)
            make.height.equalTo(NewMovieCell.bannerImageHeight)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bannerIv).offset(2)
            make.left.equalTo(bannerIv.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        ratingbar.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.width.equalTo(68)
            make.height.equalTo(16)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ratingbar.snp.right)
            make.centerY.equalTo(ratingbar).offset(-2)
            make.height.equalTo(16)
        }
        
        starEmptyTipLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.centerY.equalTo(ratingbar)
            make.height.equalTo(16)
        }
        
        genresLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(ratingbar.snp.bottom).offset(16)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(genresLabel.snp.bottom).offset(2)
        }
    }
    
    
    func setModel(_ movieSimpleInfo: MovieSimpleInfo, keyword: String? = nil)
    {
        bannerIv.app_setImage(with: movieSimpleInfo.banner, placeholder: bannerPlaceHolder,
                              options: [.transition(ImageTransition.fade(0.2))])
        
        // 设置搜索关键字的颜色
        let attrTitle = NSMutableAttributedString(string: movieSimpleInfo.title)
        if let keyword = keyword, !keyword.isBlank
        {
            let title: NSString = movieSimpleInfo.title as NSString
            for char in keyword
            {
                let range = title.range(of: String(char), options: .caseInsensitive)
                attrTitle.addAttributes([NSForegroundColorAttributeName: Colors.searchKeyword], range: range)
            }
        }
        
        titleLabel.attributedText = attrTitle
        if movieSimpleInfo.star.isNumber()
        {
            starEmptyTipLabel.isHidden = true
            ratingbar.isHidden = false
            ratingbar.rating = (movieSimpleInfo.star.toDouble()!) / 2
            ratingLabel.text = movieSimpleInfo.star
        }
        else
        {
            starEmptyTipLabel.isHidden = false
            ratingbar.isHidden = true
            ratingLabel.text = nil
        }
        
        genresLabel.text = "类型: \(movieSimpleInfo.genres)"
        countryLabel.text = "国家/地区: \(movieSimpleInfo.country)"
    }
    
    
    static var cellHeight: CGFloat
    {
        return bannerImageHeight + 16 * 2
    }
}
