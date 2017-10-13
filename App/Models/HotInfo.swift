//
//  HotInfo.swift
//  热门信息model. 对应于首页中的热门剧集/电影
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SwiftyJSON


class HotInfo: ModelType, ResourceType
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


extension HotInfo: JSONDicConvertible, JSONStringConvertible
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


extension HotInfo: CustomStringConvertible
{
    var description: String
    {
        return "HotInfo:\(jsonString)"
    }
}
