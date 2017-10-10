//
//  StageInfo.swift
//  关卡实体类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import SwiftyJSON


class StageInfo: ModelType
{
    var id: Int64           	= 0   // 关卡主键
    var idx: Int64              = 0   // 关卡序号(从1开始索引)
    var chapterId: Int64        = 0   // 关卡对应章节的ID
    var chapterIdx: Int64       = 0   // 关卡对应章节的序号(从1开始索引)
    var name: String            = ""  // 关卡名称
    var desc: String            = ""  // 关卡描述
    var icon: String            = ""  // 关卡图标URL
    var defend: Int64           = 0   // 防御值
    //var dropItems: [ItemInfo]   = []  // 掉落物品/碎片数组
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        id          = json["id"].int64Value
        idx         = json["idx"].int64Value
        chapterId   = json["chapterId"].int64Value
        chapterIdx  = json["chapterIdx"].int64Value
        name        = json["name"].stringValue
        desc        = json["desc"].stringValue
        icon        = json["icon"].stringValue
        defend      = json["defend"].int64Value
        //dropItems   = JSONUtil.readModels(json["dropItems"]) ?? []
    }
}


extension StageInfo: JSONDicConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "id"            : id,
            "idx"           : idx,
            "chapterId"     : chapterId,
            "chapterIdx"    : chapterIdx,
            "name"          : name,
            "desc"          : desc,
            "icon"          : icon,
            "defend"        : defend,
            //"dropItems"     : JSONUtil.writeModels(dropItems),
        ]
    }
}


extension StageInfo: JSONStringConvertible
{
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension StageInfo: CustomStringConvertible
{
    var description: String
    {
        return "StageInfo:\(jsonString)"
    }
}
