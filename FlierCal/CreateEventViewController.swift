//
//  DetailViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/17/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class CreateEventViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.tableFooterView = UIView()
        displayDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var imagePicked: UIImage?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBAction func createEventButton() {
        
    }
    
    @IBAction func cancelButton() {
        
    }
    
    func displayDetails() {
        var imageData: NSData = UIImageJPEGRepresentation(imagePicked, 0.5)
        //var compressedImage = UIImage(data: imageData)
        //UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)
        
        WebOCR.convertImageToString(imageData) { (imageText) -> Void in
            self.parseImageText(imageText)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "" {
            //let showConfirm: ConfirmViewController = segue.destinationViewController as! ConfirmViewController
            //println(showConfirm.imagePicked)
            //showConfirm.imagePicked = self.imagePicked!
        }
    }
    
    func parseImageText(imageText: String) {
        titleTextField.text = imageText
        // dateTextField
        // timeTextField
        // locationTextField
        // will put regex here
    }
    
}
