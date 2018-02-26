//
//  MovieInfo.swift
//  电影/电视剧信息model. 对应URL: /movie/<movie_id>/ 页面中的数据结构
//
//  Created by Sai on 11/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class MovieInfo: ModelType
{
    var title: String           = ""  // 标题
    var banner: String          = ""  // 封面图URL
    var directors: String       = ""  // 导演
    var writers: String         = ""  // 编剧
    var stars: String           = ""  // 主演
    var genres: String          = ""  // 类型
    var country: String         = ""  // 国家/地区
    var release_date: String    = ""  // 上映日期
    var runtime: String         = ""  // 片长
    var akaname: String         = ""  // 又名
    var star: String            = ""  // 评分
    var story: String           = ""  // 剧情简介
    var episode_filters: [[String: String]]   = []  // 分集查看过滤列表
    var links: [LinkInfo]                     = []  // 下载页面链接列表
    var related_resources: [ResourceInfo]     = []  // 相关资源列表
    var recommended_resources: [ResourceInfo] = []  // 推荐资源列表
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        title           = json["title"].stringValue
        banner          = json["banner"].stringValue
        directors       = json["directors"].stringValue
        writers         = json["writers"].stringValue
        stars           = json["stars"].stringValue
        genres          = json["genres"].stringValue
        country         = json["country"].stringValue
        release_date    = json["release_date"].stringValue
        runtime         = json["runtime"].stringValue
        akaname         = json["akaname"].stringValue
        star            = json["star"].stringValue
        story           = json["story"].stringValue
        episode_filters       = json["episode_filters"].arrayObject as? [[String: String]] ?? []
        links                 = JSONUtil.readModels(json["links"]) ?? []
        related_resources     = JSONUtil.readModels(json["related_resources"]) ?? []
        recommended_resources = JSONUtil.readModels(json["recommended_resources"]) ?? []
    }
}


extension MovieInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "title"         : title,
            "banner"        : banner,
            "directors"     : directors,
            "writers"       : writers,
            "stars"         : stars,
            "genres"        : genres,
            "country"       : country,
            "release_date"  : release_date,
            "runtime"       : runtime,
            "akaname"       : akaname,
            "star"          : star,
            "story"         : story,
            "episode_filters"       : episode_filters,
            "links"                 : JSONUtil.writeModels(links),
            "related_resources"     : JSONUtil.writeModels(related_resources),
            "recommended_resources" : JSONUtil.writeModels(recommended_resources),
        ]
    }
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension MovieInfo: CustomStringConvertible
{
    var description: String
    {
        return "MovieInfo:\(jsonString)"
    }
}
