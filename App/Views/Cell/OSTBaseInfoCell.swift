//
//  OSTBaseInfoCell.swift
//  "原声大碟"基本信息列表子项
//
//  Created by Sai on 30/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class OSTBaseInfoCell: UITableViewCell
{
    var titleLabel: UILabel!
    var baseInfoLabel: UILabel!
    
    
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
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        
        baseInfoLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
    }
    
    
    func setModel(_ ostInfo: OSTInfo)
    {
        titleLabel.text = ostInfo.res_name
        baseInfoLabel.text = OSTBaseInfoCell.getBaseInfoText(ostInfo: ostInfo)
    }
    
    
    private static func getBaseInfoText(ostInfo: OSTInfo) -> String
    {
        var baseInfoText = ""
        baseInfoText += !ostInfo.country.isBlank ? "地区: \(ostInfo.country)\n" : ""
        baseInfoText += !ostInfo.language.isBlank ? "语言: \(ostInfo.language)\n" : ""
        baseInfoText += !ostInfo.publish_time.isBlank ? "发行时间: \(ostInfo.publish_time)\n" : ""
        baseInfoText += !ostInfo.file_type.isBlank ? "资源格式: \(ostInfo.file_type)" : ""
        
        return baseInfoText
    }
    
    
    static func cellHeightWith(ostInfo: OSTInfo) -> CGFloat
    {
        let titleLabelWidth = ez.screenWidth - 20 * 2
        let baseInfoLabelWidth = ez.screenWidth - 20 * 2
        let baseInfoText = getBaseInfoText(ostInfo: ostInfo)
        
        let titleLabelHeight = ostInfo.res_name.height(titleLabelWidth, font: UIFont.systemFont(ofSize: 26), lineBreakMode: .byWordWrapping)
        let baseInfoLabelHeight = baseInfoText.height(baseInfoLabelWidth, font: UIFont.systemFont(ofSize: Dimens.fontSizeTiny),
                                      lineBreakMode: .byWordWrapping)
        
        return 20 + titleLabelHeight + 16 + baseInfoLabelHeight + 50
    }
}
