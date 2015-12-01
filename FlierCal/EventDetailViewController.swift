//
//  EventDetailViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/30/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit
import EventKit

extension NSDate {
    var date: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.stringFromDate(self)
    }
    var time: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.stringFromDate(self)
    }
}

class EventDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldShowBackButton() {
            anotherButton.hidden = true
        } else {
            self.navigationItem.hidesBackButton = true
        }
        
        titleLabel.text = event!.title
        timeLabel.text = event!.startDate.time
        dateLabel.text = event!.startDate.date
        locationLabel.text = event!.location
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var event: EKEvent?
    var prevPage: String?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var anotherButton: UIButton!
    
    func shouldShowBackButton() -> Bool {
        let n: Int! = self.navigationController?.viewControllers?.count
        let viewController = self.navigationController?.viewControllers[n - 2] as! UIViewController
        return (viewController.navigationItem.title! == "Events")
    }
    
}
