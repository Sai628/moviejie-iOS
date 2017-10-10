//
//  DateUtil.swift
//  日期工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import EZSwiftExtensions


struct DateUtil
{
    /**
     将 "yyyy-MM-dd HH:mm:ss" 解析为日期类型
     
     - parameter date: 日期字符串,型如: "yyyy-MM-dd"
     - parameter time: 时间字符串,型如: "HH:mm:ss"
     
     - returns: NSDate!
     */
    static func toDate(date: String, time: String) -> Date!
    {
        return "\(date) \(time)".toDate()
    }
    
    
    //MARK:-
    /// From Sai: 将 date 转换为显示的格式(常用于消息中)
    ///
    /// 返回的可能格式为:
    /// "刚刚"  "xx分钟前"  "xx小时前"  "HH:mm"(若为当天) 
    /// "昨天 HH:mm"(若为前一天)  "前天 HH:mm"(若为前两天)
    /// "MM-dd HH:mm"  "yyyy-MM-dd"(若不为当年)
    static func toStringForShow(_ date: Date) -> String
    {
        let now = Date()
        let durationTime = now.timeIntervalSince(date)
        if durationTime <= 10 * 60  // 十分钟内
        {
            return "刚刚"
        }
        else if durationTime <= 3600  // 一小时内
        {
            return "\(Int(durationTime / 60))分钟前"
        }
        else if date.isSameDay(now)
        {
            return "\(Int(durationTime / 3600))小时前"
        }
        else if date.isSameDay(now.dateWithInterval(days: -1))
        {
            return "昨天 \(date.toString(format: "HH:mm"))"
        }
        else if date.isSameDay(now.dateWithInterval(days: -2))
        {
            return "前天 \(date.toString(format: "HH:mm"))"
        }
        else if date.isSameYear(now)
        {
            return date.toString(format: "MM-dd HH:mm")
        }
        else
        {
            return date.toString(format: "yyyy-MM-dd")
        }
    }
    
    
    /// From Sai: 将消耗时间(单位毫秒)格式化为 "23:45" 或 "01:23:45" 的型式
    static func formatCountTime(millisecond: Int64) -> String
    {
        let countTime = millisecond / 1000
        if (countTime <= 0)
        {
            return "0"
        }
        else if (countTime < 60)
        {
            return String(format: "0:%2d", countTime)
        }
        else if (countTime < 3600)
        {
            let minutes = countTime / 60
            let seconds = countTime % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
        else
        {
            let hours = countTime / 3600
            let minutes = (countTime % 3600) / 60
            let seconds = countTime % 60
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
    
    /// From Sai: 获取当前时间已过去的 passDays 天的月日字符串数组
    /// 如若今天为"11.07", 则返回字符串数组型如: ["11.01", "11.02", "11.03", "11.04", "11.05", "11.06", "11.07"]
    static func getPassDayMDStrings(passDays: Int) -> [String]
    {
        var days = [String](repeating: "", count: passDays)
        var date = Date()
        for i in stride(from: passDays - 1, through: 0, by: -1)
        {
            days[i] = date.toString(format: "MM.dd")
            date = date.dateWithInterval(days: -1)
        }
        
        return days
    }
    
    
    /// From Sai: 获取时间戳对应日期的星期名称. 返回"日", "一"等名称
    static func getWeekDayName(_ timestampInSeconds: Int64) -> String
    {
        let date = timestampInSeconds.toDate()
        return ["日", "一", "二", "三", "四", "五", "六"][date.weekday - 1]
    }
}
