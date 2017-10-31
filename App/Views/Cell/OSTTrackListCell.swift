//
//  OSTTrackListCell.swift
//  "原声大碟"专辑曲目列表子项
//
//  Created by Sai on 13/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class OSTTrackListCell: UITableViewCell
{
    var trackLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if trackLabel == nil
        {
            trackLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: Colors._999)
            trackLabel.lineBreakMode = .byCharWrapping
            trackLabel.numberOfLines = 0
            self.contentView.addSubview(trackLabel)
        }
        
        trackLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(22)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    
    func setModel(_ trackList: [String])
    {
        trackLabel.text = OSTTrackListCell.getTrackText(trackList: trackList)
        trackLabel.setLineSpacing(lineSpacing: 6)
    }
    
    
    private static func getTrackText(trackList: [String]) -> String
    {
        return trackList.enumerated().map{ "\($0.0). \($0.1)" }.joined(separator: "\n")
    }
    
    
    static func cellHeightWith(trackList: [String]) -> CGFloat
    {
        let trackLabelWidth = ez.screenWidth - 16 * 2
        let trackText = getTrackText(trackList: trackList)
        
        let textHeight = trackText.height(trackLabelWidth, font: UIFont.systemFont(ofSize: Dimens.fontSizeSmall),
                                      lineBreakMode: .byCharWrapping, lineSpacing: 6)
        
        return 44 + textHeight
    }
}
