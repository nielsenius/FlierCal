//
//  Regex.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 12/9/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = NSRegularExpression(pattern: pattern, options: .CaseInsensitive, error: nil)!
    }
    
    func range(input: String) -> NSRange {
        if let match = internalExpression.firstMatchInString(input, options: nil, range: NSRange(location: 0, length: count(input))) {
            return match.range
        } else {
            return NSRange()
        }
    }
    
    func match(input: String) -> String {
        return (input as NSString).substringWithRange(range(input))
    }
    
    func contains(input: String) -> Bool {
        return !NSEqualRanges(range(input), NSMakeRange(0,0))
    }
}
