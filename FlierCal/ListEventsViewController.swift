//
//  ListEventsViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/26/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit
import EventKit

extension NSDate {
    var formatted: String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yyyy, h:mm a"
        return formatter.stringFromDate(self)
    }
}

class ListEventsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
    
    override func viewWillAppear(animated: Bool) {
        if authorized! {
            appEvents = getAppEvents()
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var eventStore: EKEventStore?
    var authorized: Bool?
    var appEvents: [EKEvent]?
    
    func getAppEvents() -> [EKEvent] {
        let startDate = NSDate(timeIntervalSinceNow: -1 * 2 * 365 * 24 * 60 * 60) // 2 years ago
        let endDate = NSDate(timeIntervalSinceNow: 2 * 365 * 24 * 60 * 60) // 2 years from now
        let predicate = eventStore!.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: nil)
        let events = eventStore!.eventsMatchingPredicate(predicate) as! [EKEvent]
        var returnEvents = [EKEvent]()
        
        if events != [] {
            for e in events {
                if e.notes != nil && e.notes == "Created with FlierCal" {
                    returnEvents.append(e)
                }
            }
        }
        
        return returnEvents
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let showDetail: EventDetailViewController = segue.destinationViewController as! EventDetailViewController
            let row = tableView.indexPathForSelectedRow()!.row
            showDetail.event = appEvents![row]
        }
    }
    
    // UITableView methods
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appEvents!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel!.text = appEvents![row].title
        cell.detailTextLabel!.text = "\(appEvents![row].startDate.formatted), \(appEvents![row].location)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
    }
    
}
