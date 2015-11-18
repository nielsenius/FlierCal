//
//  DetailViewController.swift
//  FlierCal
//
//  Created by Matthew Nielsen on 11/17/15.
//  Copyright (c) 2015 Matthew Nielsen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var imageTextLabel: UILabel!
    
    var imagePicked: UIImage?
    var imageText: String?
    
    func displayDetails() {
        var imageData: NSData = UIImageJPEGRepresentation(imagePicked, 0.7)
        //var compressedImage = UIImage(data: imageData)
        //UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil)
        
        WebOCR.convertImageToString(imageData) { (imageText) -> Void in
            self.imageTextLabel.text = imageText
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "" {
            //let showConfirm: ConfirmViewController = segue.destinationViewController as! ConfirmViewController
            //println(showConfirm.imagePicked)
            //showConfirm.imagePicked = self.imagePicked!
        }
    }
    
}
