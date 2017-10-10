//
//  JSONUtil.swift
//  JSON 工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import SwiftyJSON


struct JSONUtil
{
    static func readModel<T: ModelType>(_ jsonString: String) -> T?
    {
        guard !jsonString.isEmpty else {
            return nil
        }
    
        return readModel(JSON(parseJSON: jsonString))
    }
    
    
    static func readModel<T: ModelType>(_ json: JSON, key: String) -> T?
    {
        return readModel(json[key])
    }
    
    
    static func readModel<T: ModelType>(_ jsonObject: JSON) -> T?
    {
        guard jsonObject.dictionary != nil else {
            return nil
        }
        
        return T(json: jsonObject)
    }
    
    
    static func readModels<T: ModelType>(_ jsonArrayString: String) -> [T]?
    {
        guard !jsonArrayString.isEmpty else {
            return nil
        }
        
        return readModels(JSON(parseJSON: jsonArrayString))
    }
    
    
    static func readModels<T: ModelType>(_ json: JSON, key: String) -> [T]?
    {
        return readModels(json[key])
    }
    
    
    static func readModels<T: ModelType>(_ jsonArray: JSON) -> [T]?
    {
        guard let array = jsonArray.array else {
            return nil
        }
        
        var result = [T]()
        for json in array
        {
            if json.dictionary != nil
            {
                if let t = T(json: json)
                {
                    result.append(t)
                }
            }
        }
        
        return result
    }
    
    
    static func writeModels<T: JSONStringConvertible>(_ modelArray: [T]) -> String
    {
        return "[\(modelArray.map{ $0.jsonString }.joined(separator: ","))]"
    }
}
