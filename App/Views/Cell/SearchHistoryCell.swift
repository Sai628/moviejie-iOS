//
//  SearchHistoryCell.swift
//  搜索历史列表子项
//
//  Created by Sai on 07/11/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


class SearchHistoryCell: UITableViewCell
{
    fileprivate var titleLabel: UILabel!
    fileprivate var removeIv: UIImageView!
    
    var removeMenuHandler: (() -> Void)?
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if titleLabel == nil
        {
            titleLabel = UILabel(fontSize: 16, textColor: Colors._999)
            titleLabel.textAlignment = .left
            self.contentView.addSubview(titleLabel)
        }
        if removeIv == nil
        {
            removeIv = UIImageView(image: UIImage(named: R.icon_close))
            removeIv.addTapGesture(action: { [weak self] (_) in
                self?.removeMenuHandler?()
            })
            self.contentView.addSubview(removeIv)
        }
        
        removeIv.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.width.height.equalTo(26)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(removeIv.snp.left).offset(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
    }
    
    
    func setModel(title: String)
    {
        titleLabel.text = title
    }
    
    
    static var cellHeight: CGFloat
    {
        return 44
    }
}
