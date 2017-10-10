//
//  Date+Extensions.swift
//  Date 扩展
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import UIKit
import Foundation

import EZSwiftExtensions


extension Date
{
    /// From Sai: 获取相隔N分钟对应的日期
    func dateWithInterval(minutes interval: Int) -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps.minute = interval
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取相隔N小时对应的日期
    func dateWithInterval(hours interval: Int) -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps.hour = interval
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取相隔N天对应的日期
    func dateWithInterval(days interval: Int) -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps.day = interval
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取相隔N月对应的日期
    func dateWithInterval(months interval: Int) -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps.month = interval
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    //MARK:-
    /// From Sai: 获取所在月的第一天对应的日期
    func firstDateOfMonth() -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let dayOfMonth = (calendar as NSCalendar).component(.day, from: self)
        
        var comps = DateComponents()
        comps.day = 1 - dayOfMonth
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取所在月的最后一天对应的日期
    func lastDateOfMonth() -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: self)
        
        if (range.length != NSNotFound)
        {
            let dayOfMonth = (calendar as NSCalendar).component(.day, from: self)
            var comps = DateComponents()
            comps.day = range.length - dayOfMonth
            
            return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
        }
        
        return nil
    }
    
    
    /// From Sai: 获取所在周的第一天对应的日期(默认以周一为每周的第一天)
    func firstDateOfWeek() -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let weekday = (calendar as NSCalendar).component(.weekday, from: self)
        
        var comps = DateComponents()
        if (weekday == 1)  //为周日时,向前减6天到周一
        {
            comps.day = -6
        }
        else
        {
            comps.day = 2 - weekday
        }
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取所在周的最后一天对应的日期(默认以周一为每周的第一天)
    func lastDateOfWeek() -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let weekday = (calendar as NSCalendar).component(.weekday, from: self)
        
        var comps = DateComponents()
        if (weekday == 1)  //为周日时,无须增添天数
        {
            comps.day = 0
        }
        else
        {
            comps.day = 8 - weekday
        }
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取上一个月对应的日期. 若day超过上一月最大的天数,自动变为上一个月的最后一天
    func preMonth() -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps.month = -1
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }

    
    /// From Sai: 获取下一个月对应的日期. 若day超过下一月最大的天数,自动变为下一个月的最后一天
    func nextMonth() -> Date!
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps.month = 1
        
        return (calendar as NSCalendar).date(byAdding: comps, to: self, options: NSCalendar.Options(rawValue: 0))
    }
    
    
    /// From Sai: 获取某日期的零点时间
    func zeroTimeDate() -> Date!
    {
        let dateString = self.toDateString()
        return dateString.toDate()
    }
    
    
    //MARK:-
    /// From Sai: 判断是否为同一天
    func isSameDay(_ date: Date) -> Bool
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = [.year, .month, .day]
        let compt1 = (calendar as NSCalendar).components(unitFlags, from: self)
        let compt2 = (calendar as NSCalendar).components(unitFlags, from: date)
        
        return (compt1.year == compt2.year && compt1.month == compt2.month && compt1.day == compt2.day)
    }
    
    
    /// From Sai: 判断是否为同一星期(以周一为第一天)
    func isSameWeek(_ date: Date) -> Bool
    {
        let monday1 = self.firstDateOfWeek()
        let sunday1 = self.lastDateOfWeek()
        let monday2 = date.firstDateOfWeek()
        let sunday2 = date.lastDateOfWeek()
        
        return (monday1!.isSameDay(monday2!) && sunday1!.isSameDay(sunday2!))
    }

    
    /// From Sai: 判断是否为同一年的同一月
    func isSameMonth(_ date: Date) -> Bool
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = [.year, .month]
        let compt1 = (calendar as NSCalendar).components(unitFlags, from: self)
        let compt2 = (calendar as NSCalendar).components(unitFlags, from: date)
        
        return (compt1.year == compt2.year && compt1.month == compt2.month)
    }
    
    
    /// From Sai: 判断是否为同一年
    func isSameYear(_ date: Date) -> Bool
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        return ((calendar as NSCalendar).component(.year, from: self) == (calendar as NSCalendar).component(.year, from: date))
    }
    
    
    /// From Sai: 判断是否为今天时间
    func isToday() -> Bool
    {
        return self.isSameDay(Date())
    }
    
    /// From Sai: 判断是否为已过去的时间
    func isPassTime() -> Bool
    {
        return (self.timeIntervalSinceNow < 0)
    }
    
    
    //MARK:-
    /// From Sai: Converts NSDate to String with format "yyyy-MM-dd HH:mm:ss"
    func toDateTimeString() -> String
    {
        return self.toString(format: "yyyy-MM-dd HH:mm:ss")
    }
    
    
    /// From Sai: Converts NSDate to String with format "yyyy-MM-dd"
    func toDateString() -> String
    {
        return self.toString(format: "yyyy-MM-dd")
    }
    
    
    /// From Sai: Converts NSDate to String with format "HH:mm:ss"
    func toTimeString() -> String
    {
        return self.toString(format: "HH:mm:ss")
    }
    
    
    /// From Sai: Converts NSDate to String with format "yyyy年MM月dd日"
    func toChineseDateString() -> String
    {
        return self.toString(format: "yyyy年MM月dd日")
    }
    
    
    /// From Sai: Converts NSDate to String with format "yyyy-MM-dd HH:mm"
    func toDateHMTimeString() -> String
    {
        return self.toString(format: "yyyy-MM-dd HH:mm")
    }
    
    
    /// From Sai: Converts NSDate to String with format "HH:mm"
    func toHMTimeString() -> String
    {
        return self.toString(format: "HH:mm")
    }
    
    
    /// From Sai: Converts NSDate to String with format "yyyyMMddTHHmmss"(which conform to iCalendar protocol)
    func toICalendarString() -> String
    {
        let dateString = self.toString(format: "yyyyMMdd")
        let timeString = self.toString(format: "HHmmss")
        
        return "\(dateString)T\(timeString)"
    }
    
    
    //MARK:-
    /// From Sai: year unit
    var year: Int
    {
        return (Calendar(identifier: Calendar.Identifier.gregorian) as NSCalendar).component(.year, from: self)
    }
    
    
    /// From Sai: month unit
    var month: Int
    {
        return (Calendar(identifier: Calendar.Identifier.gregorian) as NSCalendar).component(.month, from: self)
    }
    
    
    /// From Sai: dayOfMonth unit
    var dayOfMonth: Int
    {
        return (Calendar(identifier: Calendar.Identifier.gregorian) as NSCalendar).component(.day, from: self)
    }
    
    
    /// From Sai: weekday unit. is the number from 1 through 7 (where 1 is Sunday and 7 is Saturday)
    var weekday: Int
    {
        return (Calendar(identifier: Calendar.Identifier.gregorian) as NSCalendar).component(.weekday, from: self)
    }
    
    
    /// From Sai: The count of week in current month(default the first weekday of week is Monday)
    var countOfWeekInMonth: Int
    {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.firstWeekday = 2  //设置周一为每周的开始日
        
        return (calendar as NSCalendar).component(.weekOfMonth, from: self.lastDateOfMonth())
    }

    
    /// From Sai: The Julian day
    var julianDay: Int
    {
        return (self.zeroTimeDate().timeIntervalSince1970 / 86400).toInt + 2440588
    }
    
    
    /// From Sai: The millisecond interval between the date object and 00:00:00 UTC on 1 January 1970.
    var millisecondSince1970: Int64
    {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    
    /// From Sai: The minutes interval since midnight "00:00:00" of the date object
    var minutesSinceMidnight: Int
    {
        return self.secondsSinceMidnight / 60
    }
    
    
    /// From Sai: The seconds interval since midnight "00:00:00" of the date object
    var secondsSinceMidnight: Int
    {
        return self.timeIntervalSince(self.zeroTimeDate()).toInt
    }
}
