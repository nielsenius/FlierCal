//
//  DetailViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/17/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit
import EventKit

class CreateEventViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        createButton.enabled = false
        footerView.frame.size.height = UIScreen.mainScreen().bounds.height - 332
        
        eventStore = EKEventStore()
        
        switch EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent) {
        case .Authorized:
            authorized = true
        case .Denied:
            authorized = false
        default:
            eventStore!.requestAccessToEntityType(EKEntityTypeEvent, completion:
                {[weak self] (granted: Bool, error: NSError!) -> Void in
                    if granted {
                        self!.authorized = true
                    } else {
                        self!.authorized = false
                    }
                })
        }
        
        populateForm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var imagePicked: UIImage?
    var eventStore: EKEventStore?
    var authorized: Bool?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var createButton: UIBarButtonItem!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    func createEvent() {
        let startDate = convertDate(dateTextField.text)
        let endDate = startDate.dateByAddingTimeInterval(60 * 60)
        
        var event = EKEvent(eventStore: eventStore!)
        
        event.calendar = eventStore!.defaultCalendarForNewEvents
        event.title = titleTextField.text
        event.startDate = startDate
        event.endDate = endDate
        event.location = locationTextField.text
        event.notes = "Created with FlierCal"
        
        eventStore!.saveEvent(event, span: EKSpanThisEvent, error: nil)
    }
    
    func populateForm() {
        var imageData: NSData = UIImageJPEGRepresentation(imagePicked, 0.5)
        
        WebOCR.convertImageToString(imageData) { (imageText) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.parseImageText(imageText)
                self.stopLoading()
            }
        }
//        self.parseImageText("Event Name starts at 9:00 PM on December 25 at 5000 Forbes Ave")
//        self.stopLoading()
    }
    
    func stopLoading() {
        createButton.enabled = true
        loadingIndicator.stopAnimating()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "eventCreated" {
            createEvent()
            let home: FirstViewController = segue.destinationViewController as! FirstViewController
            home.shouldShowAlert = true
        }
    }
    
    func parseImageText(imageText: String) {
        let eventParser = EventParser(imageText)
        titleTextField.text = eventParser.getTitle()
        dateTextField.text = eventParser.getDate()
        timeTextField.text = eventParser.getTime()
        locationTextField.text = eventParser.getLocation()
    }
    
    func convertDate(dateString: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        var finalDate: String
        
        if Regex("[A-z]").contains(dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy h:mm a"
            finalDate = "\(dateString), 2015 \(timeTextField.text)"
        } else if Regex("(\\d{1,2})\\/(\\d{1,2})").contains(dateString) {
            dateFormatter.dateFormat = "MM/dd/yyyy h:mm a"
            finalDate = "\(dateString)/2015 \(timeTextField.text)"
        } else {
            return NSDate()
        }
        
        if let date = dateFormatter.dateFromString(finalDate) {
            return date
        } else {
            return NSDate()
        }
    }
    
}
