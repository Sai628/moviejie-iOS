//
//  OSTSimpleInfo.swift
//  原声大碟简略信息model. 对应URL: /new/ost/ 页面中的数据结构
//
//  Created by Sai on 24/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class OSTSimpleInfo: ModelType
{
    var movie_name: String      = ""  // 电影名称
    var ost_link: String        = ""  // 原声大碟详情页面链接
    var banner: String          = ""  // 封面图URL
    var res_name: String        = ""  // 资源名称
    var res_size: String        = ""  // 资源大小
    var country: String         = ""  // 地区/语言
    var publish_time: String    = ""  // 发行时间
    var file_type: String       = ""  // 资源格式
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        movie_name      = json["movie_name"].stringValue
        ost_link        = json["ost_link"].stringValue
        banner          = json["banner"].stringValue
        res_name        = json["res_name"].stringValue
        res_size        = json["res_size"].stringValue
        country         = json["country"].stringValue
        publish_time    = json["publish_time"].stringValue
        file_type       = json["file_type"].stringValue
    }
}


extension OSTSimpleInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "movie_name"    : movie_name,
            "ost_link"      : ost_link,
            "banner"        : banner,
            "res_name"      : res_name,
            "res_size"      : res_size,
            "country"       : country,
            "publish_time"  : publish_time,
            "file_type"     : file_type,
        ]
    }
    
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension OSTSimpleInfo: CustomStringConvertible
{
    var description: String
    {
        return "OSTSimpleInfo:\(jsonString)"
    }
}
