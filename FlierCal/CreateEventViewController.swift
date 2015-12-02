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
        
        createButton.hidden = true
        cancelButton.hidden = true
        
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
    var eventForSegue: EKEvent?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBAction func createEventButton() {
        let calendars = eventStore!.calendarsForEntityType(EKEntityTypeEvent)
        
        // http://stackoverflow.com/questions/24777496/how-can-i-convert-string-date-to-nsdate
        let startDate = NSDate()
        let endDate = startDate.dateByAddingTimeInterval(60 * 60)
        
        var event = EKEvent(eventStore: eventStore!)

        event.calendar = eventStore!.defaultCalendarForNewEvents
        event.title = titleTextField.text
        event.startDate = startDate
        event.endDate = endDate
        event.location = locationTextField.text
        event.notes = "Created with FlierCal"
        
        eventForSegue = event
        //eventStore!.saveEvent(event, span: EKSpanThisEvent, error: nil)
    }
    
    func populateForm() {
        var imageData: NSData = UIImageJPEGRepresentation(imagePicked, 0.5)
        
//        WebOCR.convertImageToString(imageData) { (imageText) -> Void in
//            self.parseImageText(imageText)
//            self.stopLoading()
//        }
        self.parseImageText("text")
        self.stopLoading()
    }
    
    func stopLoading() {
        createButton.hidden = false
        cancelButton.hidden = false
        loadingIndicator.stopAnimating()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let showDetail: EventDetailViewController = segue.destinationViewController as! EventDetailViewController
            showDetail.event = eventForSegue
        }
    }
    
    func parseImageText(imageText: String) {
        titleTextField.text = "Camp Kesem"
        dateTextField.text = "1/1/16"
        timeTextField.text = "12:00 PM"
        locationTextField.text = "5000 Forbes Ave"
    }
    
}
