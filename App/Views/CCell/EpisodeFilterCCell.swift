//
//  EpisodeFilterCCell.swift
//  "分集过滤"集合视图子项
//
//  Created by Sai on 26/02/2018.
//  Copyright © 2018 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class EpisodeFilterCCell: UICollectionViewCell
{
    fileprivate var layoutBtn: UIButton!
    fileprivate var episodeLabel: UILabel!
    
    var layoutClickedHandler: (() -> Void)?
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        if layoutBtn == nil
        {
            layoutBtn = UIButton()
            layoutBtn.setCornerRadius(radius: 5)
            layoutBtn.addTapGesture(action: { [weak self] (_) in
                self?.layoutClickedHandler?()
            })
            contentView.addSubview(layoutBtn)
        }
        
        if episodeLabel == nil
        {
            episodeLabel = UILabel(fontSize: Dimens.fontSizeSmall, textColor: Colors._333, isBold: true)
            episodeLabel.textAlignment = .center
            layoutBtn.addSubview(episodeLabel)
        }
        
        layoutBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        episodeLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    func setModel(text: String, isSelected: Bool)
    {
        layoutBtn.setBackgroundColor(Colors.ccellItemNormalBg, forState: .normal)
        layoutBtn.setBackgroundColor(Colors.ccellItemHighlightBg, forState: .highlighted)
        
        episodeLabel.text = text
        episodeLabel.textColor = isSelected ? Colors.link : Colors._333
    }
    
    
    static var cellSize: CGSize
    {
        return CGSize(width: 56, height: 56)
    }
}
