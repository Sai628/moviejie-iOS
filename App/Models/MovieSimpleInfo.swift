//
//  MovieInfo.swift
//  电影/电视剧简略信息model. 对应URL: /new/movie/ 与 /new/tv/ 页面中的数据结构
//
//  Created by Sai on 23/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class MovieSimpleInfo: ModelType
{
    var title: String           = ""  // 标题
    var movie_link: String      = ""  // 电影详情页面链接
    var banner: String          = ""  // 封面图URL
    var genres: String          = ""  // 类型
    var country: String         = ""  // 国家/地区
    var star: String            = ""  // 评分
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        title           = json["title"].stringValue
        movie_link      = json["movie_link"].stringValue
        banner          = json["banner"].stringValue
        genres          = json["genres"].stringValue
        country         = json["country"].stringValue
        star            = json["star"].stringValue
    }
}


extension MovieSimpleInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "title"         : title,
            "movie_link"    : movie_link,
            "banner"        : banner,
            "genres"        : genres,
            "country"       : country,
            "star"          : star,
        ]
    }
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension MovieSimpleInfo: CustomStringConvertible
{
    var description: String
    {
        return "MovieSimpleInfo:\(jsonString)"
    }
}
