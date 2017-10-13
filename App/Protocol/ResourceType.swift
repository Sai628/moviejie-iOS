//
//  ResourceType.swift
//  资源类型(协议)
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


protocol ResourceType
{
    var category: String {get set}  // 类别名称
    var resources: [ResourceInfo] {get set}  // 资源列表
}
