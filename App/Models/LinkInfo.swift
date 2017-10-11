//
//  LinkInfo.swift
//  下载链接信息model. 对应URL: /movie/<movie_id> 页面中下载链接列表每项的数据结构
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class LinkInfo: ModelType
{
    var name: String    = ""  // 资源名称
    var size: String    = ""  // 资源大小
    var dimen: String   = ""  // 资源尺寸
    var format: String  = ""  // 资源格式
    var link: String    = ""  // 资源下载页面链接
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        name    = json["name"].stringValue
        size    = json["size"].stringValue
        dimen   = json["dimen"].stringValue
        format  = json["format"].stringValue
        link    = json["link"].stringValue
    }
}


extension LinkInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "name": name,
            "size": size,
            "dimen": dimen,
            "format": format,
            "link": link,
        ]
    }
    
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension LinkInfo: CustomStringConvertible
{
    var description: String
    {
        return "LinkInfo:\(jsonString)"
    }
}
