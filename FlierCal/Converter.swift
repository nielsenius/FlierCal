//
//  Converter.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 12/20/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import Foundation

class Converter {
    
    let inputDate: String
    let inputTime: String
    
    init(inputDate: String, inputTime: String) {
        self.inputDate = inputDate
        self.inputTime = inputTime
    }
    
    func convertDate() -> String {
        if inputDate == "" {
            return getToday()
        } else if Regex("[A-z]").contains(inputDate) {
            if Regex("[0-9]{4}").contains(inputDate) {
                return inputDate
            } else {
                return "\(inputDate), \(getYear())"
            }
        } else {
            return inputDate
        }
    }
    
    func convertTime() -> String {
        if inputTime == "" {
            return "12:00 PM"
        } else if !Regex(":").contains(inputTime) {
            let time = Regex("[0-9]+").match(inputTime)
            let sign = Regex("PM|AM").match(inputTime)
            return "\(time):00 \(sign)"
        } else if !Regex("PM|AM").contains(inputTime) {
            return "\(inputTime) PM"
        } else if !Regex(" ").contains(inputTime) {
            let time = Regex("([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]").match(inputTime)
            let sign = Regex("PM|AM").match(inputTime)
            return "\(time) \(sign)"
        } else {
            return inputTime
        }
    }
    
    func convertToNSDate() -> NSDate {
        let dateFormatter = NSDateFormatter()
        let dateString = convertDate()
        let timeString = convertTime()
        let dateTimeString = "\(dateString) \(timeString)"
        
        if Regex("[A-z]").contains(dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
        } else {
            dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        }
        
        if let d = dateFormatter.dateFromString(dateTimeString) {
            return d
        } else {
            return NSDate()
        }
    }
    
    func getToday() -> String {
        let d = NSDate()
        let f = NSDateFormatter()
        f.dateStyle = .ShortStyle
        return f.stringFromDate(d)
    }
    
    func getYear() -> String {
        let d = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(.CalendarUnitYear, fromDate: d)
        return String(components.year)
    }
    
}
