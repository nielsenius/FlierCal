//
//  ConfirmViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/17/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        imagePickedView.image = imagePicked!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imagePickedView: UIImageView!
    
    var imagePicked: UIImage?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showCreateEvent" {
            let createEvent: CreateEventViewController = segue.destinationViewController as! CreateEventViewController
            createEvent.imagePicked = self.imagePicked!
        }
    }
    
}
