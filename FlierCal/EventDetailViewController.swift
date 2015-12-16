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
        formatter.dateFormat = "eeee, MMM dd, yyyy"
        return formatter.stringFromDate(self)
    }
    var time: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.stringFromDate(self)
    }
}

class EventDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = event!.title
        dateLabel.text = event!.startDate.date
        timeLabel.text = "Starts at \(event!.startDate.time)"
        locationLabel.text = event!.location
        
        infoView.layer.borderWidth = 1
        infoView.layer.cornerRadius = 8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var event: EKEvent?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    
    @IBAction func shareButton() {
        let eventDetails = [
            "Title: \(titleLabel.text!)",
            "Time: \(timeLabel.text!)",
            "Date: \(dateLabel.text!)",
            "Location: \(locationLabel.text!)"
        ]
        let activityViewController = UIActivityViewController(activityItems: eventDetails, applicationActivities: nil)
        activityViewController.view.tintColor = self.view.tintColor
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
    @IBAction func openCalButton() {
        UIApplication.sharedApplication().openURL(NSURL(string: "calshow://")!)
    }
    
}
