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
import TagListView


class SearchHistoryCell: UITableViewCell
{
    fileprivate var searchTipLabel: UILabel!
    fileprivate var clearUpBtn: UIButton!
    fileprivate var tagListView: TagListView!
    
    var clearUpMenuHandler: (() -> Void)?
    var onTagItemClicked: ((String) -> Void)?
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        if searchTipLabel == nil
        {
            searchTipLabel = UILabel(fontSize: 14, textColor: Colors._999)
            searchTipLabel.textAlignment = .left
            searchTipLabel.text = "搜索历史"
            contentView.addSubview(searchTipLabel)
        }
        
        if clearUpBtn == nil
        {
            clearUpBtn = UIButton(type: .custom)
            clearUpBtn.contentEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 0)
            clearUpBtn.setImage(UIImage(named: R.icon_clearup_normal), for: .normal)
            clearUpBtn.setImage(UIImage(named: R.icon_clearup_highlight), for: .highlighted)
            clearUpBtn.addTapGesture(action: { [weak self] (_) in
                self?.clearUpMenuHandler?()
            })
            contentView.addSubview(clearUpBtn)
        }
        
        if tagListView == nil
        {
            tagListView = TagListView()
            tagListView.borderColor = Colors._DDD
            tagListView.tagBackgroundColor = UIColor.white
            tagListView.tagHighlightedBackgroundColor = Colors.itemClickedBg
            tagListView.textFont = UIFont.systemFont(ofSize: 14)
            tagListView.textColor = Colors._333
            tagListView.selectedTextColor = Colors._333
            tagListView.borderWidth = 0.5
            tagListView.cornerRadius = 15
            tagListView.paddingX = 16
            tagListView.paddingY = 8
            tagListView.marginX = 8
            tagListView.marginY = 8
            tagListView.delegate = self
            self.contentView.addSubview(tagListView)
        }
        
        searchTipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        clearUpBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(2)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        tagListView.snp.makeConstraints { (make) in
            make.top.equalTo(searchTipLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(110)
        }
    }
    
    
    func setModel(tagList: [String])
    {
        tagListView.removeAllTags()
        tagList.forEachEnumerated { (_, tag) in
            self.tagListView.addTag(tag)
        }
    }
    
    
    static var cellHeight: CGFloat
    {
        return 170
    }
}


extension SearchHistoryCell: TagListViewDelegate
{
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView)
    {
        self.onTagItemClicked?(title)
    }
}
