//
//  NewOSTCell.swift
//  最新原声大碟列表子项
//
//  Created by Sai on 26/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import Kingfisher
import SnapKit


class NewOSTCell: UITableViewCell
{
    fileprivate var bannerIv: UIImageView!
    fileprivate var movieNameLabel: UILabel!
    fileprivate var resInfoLabel: UILabel!
    fileprivate var countryLabel: UILabel!
    fileprivate var publishTimeLabel: UILabel!
    
    fileprivate var bannerPlaceHolder: UIImage!
    static let bannerImageHeight: CGFloat = 110
    static let bannerImageWidth: CGFloat = bannerImageHeight * 0.72

    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if bannerPlaceHolder == nil
        {
            bannerPlaceHolder = ImageUtil.create(withColor: Colors._EEE,
                                                 andSize: CGSize(width: NewOSTCell.bannerImageWidth, height: NewOSTCell.bannerImageHeight))
        }
        if bannerIv == nil
        {
            bannerIv = UIImageView()
            bannerIv.clipsToBounds = true
            bannerIv.contentMode = .scaleAspectFill
            contentView.addSubview(bannerIv)
        }
        if movieNameLabel == nil
        {
            movieNameLabel = UILabel(fontSize: 17, textColor: Colors._333, isBold: true)
            movieNameLabel.lineBreakMode = .byCharWrapping
            movieNameLabel.numberOfLines = 2
            contentView.addSubview(movieNameLabel)
        }
        if resInfoLabel == nil
        {
            resInfoLabel = UILabel(fontSize: 11, textColor: Colors._999)
            contentView.addSubview(resInfoLabel)
        }
        if countryLabel == nil
        {
            countryLabel = UILabel(fontSize: 12, textColor: Colors._AAA)
            contentView.addSubview(countryLabel)
        }
        if publishTimeLabel == nil
        {
            publishTimeLabel = UILabel(fontSize: 12, textColor: Colors._AAA)
            contentView.addSubview(publishTimeLabel)
        }
        
        bannerIv.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(NewOSTCell.bannerImageWidth)
            make.height.equalTo(NewOSTCell.bannerImageHeight)
        }
        
        movieNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bannerIv).offset(2)
            make.left.equalTo(bannerIv.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        resInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            make.left.equalTo(movieNameLabel)
            make.height.equalTo(14)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(movieNameLabel)
            make.top.equalTo(resInfoLabel.snp.bottom).offset(16)
        }
        
        publishTimeLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(movieNameLabel)
            make.top.equalTo(countryLabel.snp.bottom).offset(2)
        }
    }
    
    
    func setModel(_ ostInfo: OSTSimpleInfo)
    {
        bannerIv.app_setImage(with: ostInfo.banner, placeholder: bannerPlaceHolder, options: [.transition(ImageTransition.fade(0.2))])
        movieNameLabel.text = ostInfo.movie_name
        resInfoLabel.text = "\(!ostInfo.file_type.isBlank ? ostInfo.file_type : "-") | \(!ostInfo.res_size.isBlank ? ostInfo.res_size : "-")"
        countryLabel.text = "地区/语言: \(ostInfo.country)"
        publishTimeLabel.text = "发行时间: \(ostInfo.publish_time)"
    }
    
    
    static var cellHeight: CGFloat
    {
        return bannerImageHeight + 16 * 2
    }
}
