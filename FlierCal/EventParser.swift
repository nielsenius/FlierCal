//
//  File.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 12/17/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import Foundation

class EventParser {
    
    let rawText: String
    
    init(_ rawText: String) {
        self.rawText = rawText
    }
    
    func getTitle() -> String {
        let a = split(rawText) {$0 == " "}
        return "\(a[0]) \(a[1])"
    }
    
    func getDate() -> String {
        let dateRegex1 = "(\\d{1,2})\\/(\\d{1,2})"
        let dateRegex2 = "(jan|january|feb|february|mar|march|apr|april|may|jun|june|jul|july|aug|august|sep|september|oct|october|nov|november|dec|december) ([0-9]{1,2})"
        if Regex(dateRegex1).contains(rawText) {
            return Regex(dateRegex1).match(rawText)
        } else if Regex(dateRegex2).contains(rawText) {
            return Regex(dateRegex2).match(rawText)
        } else {
            return ""
        }
    }
    
    func getTime() -> String {
        let timeRegex = "[0-9]{1,2}(:+[0-9]{1,2})? ?(PM|pm|AM|am)*"
        if Regex(timeRegex).contains(rawText) {
            return Regex(timeRegex).match(rawText)
        } else {
            return ""
        }
    }
    
    func getLocation() -> String {
        let locationRegex = "\\d+\\s+\\w+\\s+(?:st(?:\\.|reet)?|ave(?:\\.|nue)?|lane|dr(?:\\.|ive)?)"
        if Regex(locationRegex).contains(rawText) {
            return Regex(locationRegex).match(rawText)
        } else {
            return ""
        }
    }
    
}
