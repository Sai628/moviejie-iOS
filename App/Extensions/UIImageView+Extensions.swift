//
//  UIImageView+Extensions.swift
//  UIImageView 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation

import Kingfisher


extension UIImageView
{
    convenience init(frame: CGRect, named: String)
    {
        self.init(frame: frame)
        self.image = UIImage(named: named)
    }
    
    
    func app_setImage(with urlString: String, placeholderName: String)
    {
        app_setImage(with: urlString, placeholder: UIImage(named: placeholderName))
    }
    
    
    func app_setImage(with urlString: String, placeholder: UIImage? = nil, options: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil)
    {
        if let url = URL(string: urlString)
        {
            self.kf.setImage(with: url, placeholder: placeholder, options: options, progressBlock: progressBlock, completionHandler: completionHandler)
        }
    }
}
