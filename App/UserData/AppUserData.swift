//
//  AppUserData.swift
//  应用用户数据操作类
//
//  Created by Sai on 07/11/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


struct AppUserData
{
    /// 搜索历史
    static let SEARCH_HISTORY = "search_history"
    
    fileprivate static let searchHistoryMaxCacheLength = 20   //搜索历史数组缓存的最大长度为20
    
    
    //MARK:-
    /// 获取应用的搜索历史字符串数组, 没有搜索历史时, 返回一个空数组
    static func getSearchHistory() -> [String]
    {
        return getUserData(SEARCH_HISTORY) as? [String] ?? []
    }
    
    
    /// 保存应用的搜索历史字符串数组
    static func saveSearchHistory(_ searchHistories: [String])
    {
        let array: [String] = Array(searchHistories[0..<min(searchHistories.count, searchHistoryMaxCacheLength)])
        saveUserData(array, forKey: SEARCH_HISTORY)
    }
    
    
    //MARK:-
    static func getUserData(_ key: String) -> Any?
    {
        return UserDefaults.standard.object(forKey: key)
    }
    
    
    static func saveUserData(_ value: Any, forKey defaultName: String)
    {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: defaultName)
        defaults.synchronize()
    }
    
    
    static func removeUserData(_ key: String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }
}
