//
//  LoadingMenu.swift
//  "加载布局"视图
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SnapKit


protocol LoadingMenuDelegate: class
{
    func onRetryClicked(_ view: LoadingMenu)
}


class LoadingMenu: UIView
{
    private let emptyPromptIv = UIImageView()
    private let emptyPromptLabel = UILabel()
    private let retryPromptLabel = UILabel()
    private let indicatorView = UIActivityIndicatorView()
    
    private var gestureRecognizer: UIGestureRecognizer!
    
    weak var delegate: LoadingMenuDelegate?
    
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setUp()
    }

    
    private func setUp()
    {
        backgroundColor = UIColor.white
        
        emptyPromptIv.image = UIImage(named: R.icon_empty_prompt)
        emptyPromptIv.isHidden = true
        addSubview(emptyPromptIv)
        
        emptyPromptLabel.font = UIFont.systemFont(ofSize: 16)
        emptyPromptLabel.textAlignment = .center
        emptyPromptLabel.textColor = Colors.hint
        emptyPromptLabel.text = Strings.empty_data_prompt
        emptyPromptLabel.isHidden = true
        addSubview(emptyPromptLabel)

        retryPromptLabel.font = UIFont.systemFont(ofSize: 16)
        retryPromptLabel.textAlignment = .center
        retryPromptLabel.textColor = Colors.hint
        retryPromptLabel.text = Strings.network_error_retry_prompt
        retryPromptLabel.isHidden = true
        addSubview(retryPromptLabel)
        
        indicatorView.hidesWhenStopped = true
        indicatorView.activityIndicatorViewStyle = .gray
        indicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicatorView.isHidden = true
        addSubview(indicatorView)
        
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClicked))
        addGestureRecognizer(gestureRecognizer)
        
        emptyPromptIv.snp.makeConstraints { (make) in
            make.width.height.equalTo(85)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        emptyPromptLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyPromptIv.snp.bottom).offset(10)
        }
        
        retryPromptLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.center.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
    
    
    var emptryPrompt: String = Strings.empty_data_prompt
    {
        didSet
        {
            emptyPromptLabel.text = emptryPrompt
        }
    }
    
    
    func showLoading()
    {
        isHidden = false
        
        emptyPromptIv.isHidden = true
        emptyPromptLabel.isHidden = true
        retryPromptLabel.isHidden = true
        indicatorView.startAnimating()
    }
    
    
    func showFail(_ promptText: String = Strings.network_error_retry_prompt)
    {
        isHidden = false
        
        emptyPromptIv.isHidden = true
        emptyPromptLabel.isHidden = true
        indicatorView.stopAnimating()
        
        retryPromptLabel.text = promptText
        retryPromptLabel.isHidden = false
        
        if let cognizer = gestureRecognizer
        {
            removeGestureRecognizer(cognizer)
        }
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onClicked))
        addGestureRecognizer(gestureRecognizer)
    }
    
    
    func showEmpty(_ promptText: String = Strings.empty_data_prompt)
    {
        isHidden = false
        
        retryPromptLabel.isHidden = true
        indicatorView.stopAnimating()

        emptyPromptIv.isHidden = false
        emptyPromptLabel.text = promptText
        emptyPromptLabel.isHidden = false
        
        if let cognizer = gestureRecognizer
        {
            removeGestureRecognizer(cognizer)
        }
    }
    
    
    func dismiss()
    {
        guard !isHidden else {
            return
        }
        
        isHidden = true
    }
    
    
    func onClicked()
    {
        guard !indicatorView.isAnimating else {
            return
        }
        
        showLoading()
        self.delegate?.onRetryClicked(self)
    }
}
