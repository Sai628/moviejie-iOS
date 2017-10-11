//
//  RelInfo.swift
//  相关电影/电视剧. 对应URL: /movie/<movie_id> 页面中的"相关影视"/"猜你喜欢"数据结构
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions
import SwiftyJSON


class RelInfo: ModelType
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


extension RelInfo: JSONDicConvertible, JSONStringConvertible
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


extension RelInfo: CustomStringConvertible
{
    var description: String
    {
        return "RelInfo:\(jsonString)"
    }
}
