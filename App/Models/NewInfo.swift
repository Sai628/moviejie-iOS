//
//  NewInfo.swift
//  更新信息model. 对应于首页中的更新列表
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SwiftyJSON


class NewInfo: ModelType
{
    var category: String = ""  // 类别名称
    var resources: [ResourceInfo] = []  // 资源列表
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        category = json["category"].stringValue
        resources = JSONUtil.readModels(json["resources"]) ?? []
    }
}


extension NewInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "category": category,
            "resources": JSONUtil.writeModels(resources)
        ]
    }
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension NewInfo: CustomStringConvertible
{
    var description: String
    {
        return "NewInfo:\(jsonString)"
    }
}
