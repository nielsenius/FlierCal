//
//  ListEventsViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/26/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit
import EventKit

class ListEventsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var eventStore: EKEventStore?
    var authorized: Bool?
    
    func getAppEvents() -> [EKEvent] {
        let predicate = eventStore!.predicateForEventsWithStartDate(NSDate.distantPast() as! NSDate, endDate: NSDate.distantFuture() as! NSDate, calendars: nil)
        let events = eventStore!.eventsMatchingPredicate(predicate) as! [EKEvent]
        var appEvents = [EKEvent]()
        
        if events != [] {
            for e in events {
                if e.notes == "Created with FlierCal" {
                    println(e.title)
                    appEvents.append(e)
                }
            }
        }
        
        return appEvents
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "" {
            //let showConfirm: ConfirmViewController = segue.destinationViewController as! ConfirmViewController
            //println(showConfirm.imagePicked)
            //showConfirm.imagePicked = self.imagePicked!
        }
    }
    
}
