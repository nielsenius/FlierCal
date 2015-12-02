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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func shareButton() {
        let eventDetails = [
            "Title: \(titleLabel.text!)",
            "Time: \(timeLabel.text!)",
            "Date: \(dateLabel.text!)",
            "Location: \(locationLabel.text!)"
        ]
        let activityViewController = UIActivityViewController(activityItems: eventDetails, applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
    @IBAction func openCalButton() {
        UIApplication.sharedApplication().openURL(NSURL(string: "calshow://")!)
    }
    
}
