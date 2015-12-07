//
//  MyButton.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 12/7/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class MyButton: UIButton {
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.layer.masksToBounds = true
        self.layer.borderColor = tintColor!.CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.titleLabel!.alpha = 1.0
        self.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
    }
    
    override var highlighted: Bool {
        didSet {
            if (highlighted) {
                self.backgroundColor = tintColor
            } else {
                self.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
}
