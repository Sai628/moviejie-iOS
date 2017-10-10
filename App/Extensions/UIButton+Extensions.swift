//
//  UIButton+Extensions.swift
//  UIButton 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation

import Kingfisher


extension UIButton
{
    convenience init(fontSize: CGFloat, textColor: UIColor, type buttonType: UIButtonType = .custom)
    {
        self.init(type: buttonType)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setTitleColor(textColor, for: .normal)
    }
    
    
    func app_setImage(with urlString: String, forState state: UIControlState, placeholderName: String)
    {
        app_setImage(with: urlString, forState: state, placeholder: UIImage(named: placeholderName))
    }
    
    
    func app_setImage(with urlString: String, forState state: UIControlState, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil)
    {
        if let url = URL(string: urlString)
        {
            self.kf.setImage(with: url, for: state, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
        }
    }
}
