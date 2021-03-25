//
//  Date+Extensions.swift
//  TheMovieApp
//
//  Created by Khoa Nguyen on 23/03/2021.
//

import Foundation

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    
    var dateWithOnlyMonthString: String {
        return Formatter.dateWithOnlyMonth.string(from: self)
    }
    
    func getHisoryReadTime() -> String {
        if Date().months(from: self) > 0 {
            return R.string.localizable.reviewMonth()
        }
        
        if Date().weeks(from: self) > 0 {
            return R.string.localizable.reviewWeek(Date().weeks(from: self))
        }
        
        if Date().days(from: self) > 0 {
            return R.string.localizable.reviewDay(Date().days(from: self))
        }
        
        if Date().hours(from: self) > 0 {
            return R.string.localizable.reviewHour(Date().hours(from: self))
        }
        
        if Date().minutes(from: self) > 0 {
            return R.string.localizable.reviewMinute(Date().minutes(from: self))
        }
        
        if Date().seconds(from: self) > 0 {
            return R.string.localizable.reviewNow()
        }
        
        return R.string.localizable.reviewNow()
    }
    
}
