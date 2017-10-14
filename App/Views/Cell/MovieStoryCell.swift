//
//  MovieStoryCell.swift
//  "电影/电视剧"剧情列表子项
//
//  Created by Sai on 13/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class MovieStoryCell: UITableViewCell
{
    var storyLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if storyLabel == nil
        {
            storyLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: Colors._999)
            storyLabel.lineBreakMode = .byCharWrapping
            storyLabel.numberOfLines = 0
            self.contentView.addSubview(storyLabel)
        }
        
        storyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(22)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    
    func setModel(_ story: String)
    {
        storyLabel.text = story
        storyLabel.setLineSpacing(lineSpacing: 6)
    }
    
    
    static func cellHeightWith(story: String) -> CGFloat
    {
        let storyLabelWidth = ez.screenWidth - 16 * 2
        let textHeight = story.height(storyLabelWidth, font: UIFont.systemFont(ofSize: Dimens.fontSizeSmall),
                                      lineBreakMode: .byCharWrapping, lineSpacing: 6)
        
        return 44 + textHeight
    }
}
